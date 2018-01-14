#!/usr/bin/env ruby

class Output
  attr_accessor :name, :width, :height, :offset_x, :offset_y, :connected
end

class Xrandr
  def raw_outputs
    %x(xrandr -q).split("\n").grep(/connected/)
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
