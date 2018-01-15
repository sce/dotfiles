#!/usr/bin/env ruby

require 'pp'

class Output
  def initialize
    @resolutions = []
  end
  attr_accessor :name, :width, :height, :offset_x, :offset_y, :connected, :resolutions
end

Resolution = Struct.new(:res, :interlaced, :hz, :current, :default)

class Screen
  attr_accessor :number, :width, :height, :min_width, :min_height, :max_width, :max_height
end

class ServerLayout
  attr_accessor :screen, :outputs
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
        output.name, connected, output.width, output.height, output.offset_x, output.offset_y = match.captures
        output.connected = connected == 'connected'
        outputs.push output
      elsif match = /(\d+x\d+)(i?)\s+\d+\.\d+[ \*][ \+]/.match(line)
        res, interlaced = match.captures
        line.scan(/\s+?(\d+\.\d+)([ \*]?)([ \+]?)/).each do |(hz, current, default)|
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

pp Xrandr.new.server_layout
