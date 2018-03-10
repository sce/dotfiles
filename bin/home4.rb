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
Layout = Struct.new(:name, :outputs)

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
    Layout.new('Detected Layout', connections).to_yaml
  end
end

class Xrandr
  def raw_outputs
    %x(xrandr -q).split("\n").grep(/connected/)
  end

  def server_layout
    screen = Screen.new
    outputs = []
    output = nil
    %x(xrandr -q).split("\n").each do |line|
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

layout = Xrandr.new.server_layout
#puts layout.to_yaml
puts layout.describe

puts YAML.load_file("display-layouts.yml").to_yaml