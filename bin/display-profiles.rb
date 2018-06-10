#!/usr/bin/env ruby

require 'pp'
require 'yaml'
require_relative './dialog'

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
  def initialize name:, outputs:, orphan_outputs: [], profiles: []
    @name = name
    @outputs = outputs
    # orphan outputs == disconnected outputs. we need to know which these are
    # so that we can properly configure them during reset.
    @orphan_outputs = orphan_outputs
    @profiles = profiles
  end
  attr_reader :name, :outputs, :orphan_outputs, :profiles

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

  def all_outputs
    outputs + orphan_outputs
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
    @width, @height = res.split('x').map(&:to_i)

    @pos = pos
    @x, @y = pos.split('x').map(&:to_i)
  end

  attr_reader :name, :res, :pos, :scale, :rotate, :x, :y, :width, :height

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

# Profile: How to arrange the current layout (including resolution/scaling)
class Profile
  def initialize name, output_profiles
    @name = name
    @output_profiles = output_profiles
  end

  attr_reader :name, :output_profiles

  def to_s
    ops = @output_profiles.map do |op|
      [op.name, "#{op.scale || op.res}+#{op.x}+#{op.y}"] * " "
    end
    [@name, ops] * "\n"
  end
end

# ServerLayout describes an X setup.
class ServerLayout
  attr_accessor :screen, :outputs

  def describe
    connected, disconnected = outputs.partition {|output| output.connected }
    connections = connected.map do |output|
      res = output.resolutions.find {|res| res.default }
      res ||= output.resolutions.find {|res| res.current }
      res ||= output.resolutions.first
      {
        'name' => output.name,
        'res' => res.res,
        # hz
        # scale
        # rotate
      }
    end
    # inject auto-generated profiles:
    # - one where all outputs are active
    # - one for each output with only that output active
    single_profiles = connected.map do |output|
      res = output.resolutions.find {|res| res.default }
      res ||= output.resolutions.find {|res| res.current }
      res ||= output.resolutions.first
      output_prof = OutputProfile.new(
        name: output.name,
        res: res.res,
        pos: "0x0",
      )
      Profile.new(output.name, [output_prof])
    end

    all_profile = begin
      x = 0
      out_profiles = connected.map do |output|
        res = output.resolutions.find {|res| res.default }
        res ||= output.resolutions.find {|res| res.current }
        res ||= output.resolutions.first
        prof = OutputProfile.new(
          name: output.name,
          res: res.res,
          pos: "#{x}x0",
        )
        # just place them on a row:
        x += prof.width
        prof
      end
      Profile.new("all", out_profiles)
    end

    orphan = disconnected.map do |output| { 'name' => output.name } end
    Layout.new(
      name: 'Detected Layout',
      outputs: connections,
      orphan_outputs: orphan,
      profiles: single_profiles.concat([all_profile]),
    )
  end
end

class Xrandr
  def initialize( cmd: "/usr/bin/env xrandr", sleep_time: 0 )
    @cmd = cmd
    @sleep_time = sleep_time
  end

  def raw_outputs
    %x(#@cmd -q).split("\n").grep(/connected/)
  end

  def server_layout
    screen = Screen.new
    outputs = []
    output = nil
    # run xrandr query and parse the output:
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
    args = server_layout.describe.all_outputs.map do |output|
      %(--output #{output['name']} --transform none --off)
    end
    action = %(#@cmd \\\n  #{args.join " \\\n  "}\n#{pause})
    system action
  end

  def pause
    %(sleep #@sleep_time)
  end

  def activate profile
    # - First to a reset: Turn off everything and shift main display (0x0) to native resolution
    reset profile

    # - Then: Start activating displays left to right and then top to bottom
    out_profiles = profile.output_profiles.sort.map do |out_prof|
      on = %(--output #{out_prof.name} --auto)
      pos = %(--pos #{out_prof.pos})
      rotate = out_prof.rotate && %(--rotate #{out_prof.rotate})
      scale = out_prof.scale && %(--scale-from #{out_prof.scale})

      args = ([on, pos, rotate].reject {|o| o.nil? }).join(" \\\n  ")
      actions = [%(#@cmd \\\n  #{args})]
      if scale
        # For some reason activating scaling when activating the display often
        # causes problems (on my setup), e.g. blank displays. This is mitigated
        # by first activating the display, and then turning on scaling.
        args = ([on, scale].reject {|o| o.nil? }).join(" \\\n  ")
        actions.push %(#@cmd \\\n  #{args})
      end
      actions
    end
    action = out_profiles.join("\n#{pause}\n")
    system action
  end

  private

  def system cmd
    puts cmd
    Kernel.system cmd
  end
end

class LayoutManager
  def initialize xrandr: Xrandr.new
    @xrandr = xrandr
    @layout = nil
    @layouts = []
  end

  SUPPORTED_CONFIG = 0

  def parse_file filename
    #puts YAML.load_file(filename).to_yaml
    config = YAML.load_file(filename).first

    if (config_version = config["config_version"].to_i) > SUPPORTED_CONFIG
      $stderr.puts msg = %(%s: Software supports config versions up to "%i" but this file was "%i", quitting.) %
        [filename, SUPPORTED_CONFIG, config_version]

      MessageDialog.new(title: "Error", text: msg).run
      exit 1
    end

    puts %(Config is version "%i") % config_version

    if config_version == 0
      orphans = @xrandr.server_layout.describe.orphan_outputs
      @layouts = config["layouts"].map do |layout|
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

        Layout.new(
          name: layout["name"],
          outputs: layout["outputs"],
          # TODO Merging in orphan outputs here is not that elegant; they should
          # be queried on demand or something. They are needed during reset.
          orphan_outputs: orphans,
          profiles: profiles
        )
      end
    end
  end

  def current_layout
    @layout = @xrandr.server_layout.describe
    return @layout unless @layouts.any?
    @current_layout = @layouts.find do |layout|
      layout == @layout
    end || @layout
  end
end

# TODO:
# - Automatically create (or at least ask to create) display-profiles.yml with
#   the current layout and profile if it does not exist.
# - Detect and ask to add the current profile to the current layout in
#   display-profiles.yml if it does not exist.
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

    config_file = find_config
    mngr.parse_file config_file

    puts "CURRENT LAYOUT:"
    pp current = mngr.current_layout

    unless current.profiles.any?
      $stderr.puts msg = %(Current layout is not in config!\n\n#{current}\n)
      MessageDialog.new(title: "Error", text: msg).run
      exit 1
    end

    exit(0) unless wants_profile = find_profile || choose_profile(current)

    unless profile = current.profiles.find { |prof| prof.name.to_s == wants_profile.to_s }
      $stderr.puts msg = %(Can't find profile "%s") % wants_profile
      MessageDialog.new(title: "Error", text: msg).run
      exit(1)
    end

    puts "\nCHOSEN PROFILE:"
    pp profile
    xrandr.activate(profile)
  end

  private

  def self.find_profile
    ARGV.select {|s| s !~ /\.yml/i }.first
  end

  def self.find_config
    config_paths = %W(
      ./display-profiles.yml
      #{ENV['HOME']}/display-profiles.yml
      #{ENV['HOME']}/.config/display-profiles/display-profiles.yml
    )
    filenames = config_paths.concat ARGV.select { |s| s =~ /\.yml/i }

    config_file = filenames.find do |filename|
      File.exists? filename
    end

    unless config_file
      $stderr.puts msg = %(Can't find config file in #{config_paths.join(", ")}.)
      MessageDialog.new(title: "Error", text: msg).run
      exit 1
    end
    puts %(Using config file "%s") % config_file
    config_file
  end

  def self.choose_profile current
    options = current.profiles.map do |profile|
      [profile.name, profile.to_s, "off"]
    end
    dialog = RadiolistDialog.new \
      title: "Choose profile",
      backtitle: %(Current layout is "#{current.name}"),
      text: current,
      options: options
    choice = dialog.run
    choice == "" ? nil : choice
  end
end

DisplayProfiles.run
