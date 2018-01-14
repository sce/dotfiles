#!/usr/bin/env ruby

class Output
  def self.parse_xrandr(xrandr_text)
    output = self.new

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

  attr_accessor :name, :width, :height, :offset_x, :offset_y, :connected
end

def outputs
  %x(xrandr -q).split("\n").grep(/connected/)
end

outputs.each do |txt|
  p Output.parse_xrandr(txt)
end
