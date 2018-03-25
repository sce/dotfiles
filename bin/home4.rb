#!/usr/bin/env ruby

require 'pp'
require 'yaml'
require './dialog'

Resolution = Struct.new(:res, :interlaced, :hz, :current, :default)

class Output
  def initialize
    @resolutions = []
  end
  attr_accessor :name, :width, :height, :offset_x, :offset_y, :connected, :resolutions, :rotation
end

class Screen
  attr_accessor :number, :width, :height, :min_width, :min_height, :max_width, :max_height
end

# Layout: Combination of outputs and monitors (which outputs exist that are connected to what monitors)
class Layout
  def initialize name, outputs, profiles = []
    @name = name
    @outputs = outputs
    @profiles = profiles
  end
  attr_reader :name, :outputs, :profiles

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

  def to_s
    ([@name].concat @outputs.map {|op| op.values_at('name', 'res') * " " }) * "\n"
  end
end

# Profile: How to arrange the current layout (including resolution/scaling)
# OutputProfile: A single output in a Profile.
class OutputProfile
  def initialize name:, res:, pos:, scale: nil, rotate: nil
    @name = name
    @scale = scale
    @rotate = rotate
    @res = res
    @pos = pos
    @x, @y = pos.split('x').map(&:to_i)
  end
  attr_reader :name, :res, :pos, :scale, :rotate, :x, :y

  def <=> other
    # Sort by position:
    # - First left to right
    # - Then top to bottom
    if x == other.x
      y <=> other.y
    else
      x <=> other.x
    end
  end

  def inspect
    %(#<OutputProfile name=%s pos=%s res=%s rotate=%s scale=%s>) % [
      @name, @pos, @res, @rotate, @scale
    ].map(&:inspect)
  end
end

class Profile
  def initialize name, output_profiles
    @name = name
    @output_profiles = output_profiles
  end

  attr_reader :name, :output_profiles

  def to_s
    ops = @output_profiles.map do |op|
      [op.name, "#{op.res}@#{op.x}x#{op.y}"] * " "
    end
    [@name, ops] * "\n"
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
  def initialize( cmd: "/usr/bin/env xrandr", sleep_time: 0 )
    @cmd = cmd
    @sleep_time = sleep_time
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
      elsif match = /\A(.+)\s((?:dis)?connected)\s(?:primary\s)?(?:(\d+)x(\d+)\+(\d+)\+(\d+))?\s?(?:[^()]*)/.match(line)
        output = Output.new
        # Note: Width and height include any scaling involved.
        output.name, connected, output.width, output.height, output.offset_x, output.offset_y, output.rotation = match.captures
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

  def reset profile
    puts "DOING RESET"
    args = server_layout.describe.outputs.map do |output|
      %(--output #{output['name']} --transform none --off)
    end
    puts action = %(#@cmd \\\n  #{args.join " \\\n  "}\n#{pause})
    puts %x(#{action})
  end

  def pause
    "sleep #@sleep_time"
  end

  def activate profile
    # - First to a reset: Turn off everything and shift main display (0x0) to native resolution
    # - Then: Start activating displays left to right and then top to bottom
    reset profile
    out_profiles = profile.output_profiles.sort.map do |out_prof|
      on = %(--output #{out_prof.name} --auto)
      pos = %(--pos #{out_prof.pos})
      rotate = out_prof.rotate && %(--rotate #{out_prof.rotate})
      scale = out_prof.scale && %(--scale-from #{out_prof.scale})
      args = ([on, pos, rotate, scale].reject {|o| o.nil? }).join(" \\\n  ")
      action = %(#@cmd \\\n  #{args})
    end
    puts action = out_profiles.join("\n#{pause}\n")
    puts %x(#{action})
  end
end

class LayoutManager
  def initialize xrandr: Xrandr.new
    @xrandr = xrandr
    @layout = nil
    @layouts = []
  end

  def parse_file filename
    #puts YAML.load_file(filename).to_yaml
    @layouts = YAML.load_file(filename).first["layouts"]
      .map do |layout|
        profiles = layout["profiles"].map do |profile|
           output_profiles = profile["outputs"].map do |out_prof|
             OutputProfile.new(
                name: out_prof['name'],
                res: out_prof['res'],
                scale: out_prof['scale'],
                rotate: out_prof['rotate'],
                pos: out_prof['pos']
             )
           end
           Profile.new(profile["name"], output_profiles)
        end

        Layout.new(layout["name"], layout["outputs"], profiles)
      end
  end

  def current_layout
    @layout = @xrandr.server_layout.describe
    return @layout unless @layouts.any?
    @current_layout = @layouts.find do |layout|
      layout == @layout
    end
  end
end

# TODO:
# - Automatically create (or at least ask to create) display-layouts.yml with
#   the current layout and profile if it does not exist.
# - Detect and ask to add the current profile to the current layout in
#   display-layouts.yml if it does not exist.
#   ---
#   - layouts:
#     - name: Detected
#       outputs:
#       - name: HDMI-1
#         res: 1920x1080
#       profiles:
#       - name: detected
#         outputs:
#         - name: HDMI-1
#           res: 1920x1080
#           pos: "0x0"
module DisplayProfiles
  def self.run
    xrandr = Xrandr.new(sleep_time: ENV['SLEEP'] || 0)
    mngr = LayoutManager.new xrandr: xrandr
    mngr.parse_file("display-layouts.yml")

    puts "\n\nCURRENT LAYOUT:"
    pp current = mngr.current_layout

    exit(1) unless current
    exit(0) unless wants_profile = ARGV.first || choose_profile(current)
    exit(0) if wants_profile == ""

    unless profile = current.profiles.find { |prof| prof.name.to_s == wants_profile.to_s }
      $stderr.puts %(Can't find profile "%s") % wants_profile
      exit(1)
    end

    puts "\nCHOSEN PROFILE:"
    pp profile
    xrandr.activate(profile)
  end

  private

  def self.choose_profile current
    options = current.profiles.map do |profile|
      [profile.name, profile.to_s, "off"]
    end
    dialog = Dialog.new \
      title: "Choose profile",
      backtitle: %(Detected layout is "#{current.name}"),
      text: current,
      options: options
    dialog.run
  end
end

DisplayProfiles.run
