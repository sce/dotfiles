#!/usr/bin/env ruby

class Output
  def initialize xrandr_text
    #@xrandr_text = xrandr_text

    if xrandr_text =~ /\A(.+)\s((?:dis)?connected)\s(?:primary\s)?(\d+)x(\d+)\+(\d+)\+(\d+)\s/
      @name, connected, @width, @height, @offset_x, @offset_y = $1, $2, $3, $4, $5, $6
      @connected = connected == 'connected'
    elsif xrandr_text =~ /\A(.+)\s((?:dis)?connected)\s(?:primary\s)?/
      @name, connected = $1, $2
      @connected = connected == 'connected'
    else
      raise %(Can't parse "%s") % xrandr_text
    end
  end

  attr_reader :name, :width, :height, :offset_x, :offset_y
end

def outputs
  %x(xrandr -q).split("\n").grep(/connected/)
end

outputs.each do |txt|
  p Output.new(txt)
end
