#!/usr/bin/env ruby

require 'pp'
require 'yaml'

Resolution = Struct.new(:res, :interlaced, :hz, :current, :default)

class Output
  def initialize
    @resolutions = []
  end
  attr_accessor :name, :width, :height, :offset_x, :offset_y, :connected, :resolutions
end

class Screen
  attr_accessor :number, :width, :height, :min_width, :min_height, :max_width, :max_height
end

# Layout: Combination of outputs and monitors (which outputs exist that are connected to what monitors)
# Profile: How to arrange the current layout (including resolution/scaling)
Layout = Struct.new(:name, :outputs, :profiles) do
  # For two layouts to be the same we care that all the outputs are the same.
  # The order of the outputs is not important.
  def == other
    return false if outputs.count != other.outputs.count
    return false if outputs.any? do |output|
      other.outputs.none? do |other_output|
        output['name'] == other_output['name'] and
         output['res'] == other_output['res']
      end
    end
    return true
  end
end

# ServerLayout describes an X setup.
class ServerLayout
  attr_accessor :screen, :outputs

  def describe
    connections = outputs.select{|output| output.connected }.map do |output|
      res = output.resolutions.find {|res| res.default }
      {
        'name' => output.name,
        'res' => res.res,
        # hz
        # scale
        # rotate
      }
    end
    Layout.new('Detected Layout', connections)
  end
end

class Xrandr
  def initialize( cmd: "/usr/bin/env xrandr" )
    @cmd = cmd
  end

  def raw_outputs
    %x(xrandr -q).split("\n").grep(/connected/)
  end

  def server_layout
    screen = Screen.new
    outputs = []
    output = nil
    %x(#@cmd -q).split("\n").each do |line|
      if match = /Screen (\d+): (?:minimum (\d+) x (\d+), )?(?:current (\d+) x (\d+), )?(?:maximum (\d+) x (\d+))/.match(line)
        screen.number,
        screen.min_width, screen.min_height,
        screen.width, screen.height,
        screen.max_width, screen.max_height =
          match.captures
      elsif match = /\A(.+)\s((?:dis)?connected)\s(?:primary\s)?(?:(\d+)x(\d+)\+(\d+)\+(\d+))?/.match(line)
        output = Output.new
        # Note: Width and height include any scaling involved.
        output.name, connected, output.width, output.height, output.offset_x, output.offset_y = match.captures
        output.connected = connected == 'connected'
        outputs.push output
      elsif match = /(\d+x\d+)(i?)\s+\d+\.\d+[ \*][ \+]/.match(line)
        res, interlaced = match.captures
        line.scan(/\s+?(\d+\.\d+)([ \*]?)([ \+]?)/).each do |(hz, current, default)|
          # Note: Resolution does not include e.g. scaling (because scaling is
          # done in software)
          output.resolutions.push Resolution.new(res, interlaced == 'i', hz.strip, current == '*', default == '+')
        end
      else
        $stderr.puts %(Can't parse "%s") % line
      end
    end
    layout = ServerLayout.new
    layout.screen = screen
    layout.outputs = outputs
    layout
  end
end

class LayoutManager
  def initialize xrandr: Xrandr.new
    @xrandr = xrandr
    @layout = nil
    @layouts = nil
  end

  def parse_file filename
    #puts YAML.load_file(filename).to_yaml
    @layouts = YAML.load_file(filename).first["layouts"]
      .map {|layout| Layout.new(layout["name"], layout["outputs"], layout["profiles"]) }
  end

  def current_layout
    @layout = @xrandr.server_layout.describe
    @current_layout = @layouts.find do |layout|
      layout == @layout
    end
  end
end

#layout = Xrandr.new.server_layout
#puts layout.describe

mngr = LayoutManager.new
pp mngr.parse_file("display-layouts.yml")
puts "\n\nCURRENT:"
pp current = mngr.current_layout

exit(0) unless current and wants_profile = ARGV.first

unless profile = current.profiles.find { |prof| prof['name'] == wants_profile }
  $stderr.puts %(Can't find profile "%s") % wants_profile
  exit(1)
end
