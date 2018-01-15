#!/usr/bin/env ruby

class Output
  attr_accessor :name, :width, :height, :offset_x, :offset_y, :connected
end

class Screen
  attr_accessor :number, :width, :height, :min_width, :min_height, :max_width, :max_height
end

class Xrandr
  def raw_outputs
    %x(xrandr -q).split("\n").grep(/connected/)
  end

  def raw_outputs2
    screen = Screen.new
    %x(xrandr -q).split("\n").each do |line|
      if match = /Screen (\d+): (?:minimum (\d+) x (\d+), )?(?:current (\d+) x (\d+), )?(?:maximum (\d+) x (\d+))/.match(line)
        screen.number,
        screen.min_width, screen.min_height,
        screen.width, screen.height,
        screen.max_width, screen.max_height =
          match.captures
      end
    end
    screen
  end

  def outputs
    raw_outputs.map do |output_line|
      parse_xrandr(output_line)
    end
  end

  private

  def parse_xrandr(xrandr_text)
    output = Output.new

    if xrandr_text =~ /\A(.+)\s((?:dis)?connected)\s(?:primary\s)?(\d+)x(\d+)\+(\d+)\+(\d+)\s/
      output.name, connected, output.width, output.height, output.offset_x, output.offset_y = $1, $2, $3, $4, $5, $6
      output.connected = connected == 'connected'
    elsif xrandr_text =~ /\A(.+)\s((?:dis)?connected)\s(?:primary\s)?/
      output.name, connected = $1, $2
      output.connected = connected == 'connected'
    else
      raise %(Can't parse "%s") % xrandr_text
    end
    output
  end
end

Xrandr.new.outputs.each do |output|
  p output
end
