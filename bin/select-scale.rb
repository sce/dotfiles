#!/usr/bin/env ruby

require 'pp'
require 'json'

def notify msg
  # on some monitors it might take about 3 seconds to actually change resolution:
  %x(notify-send -t 6000 "#{msg}")
end

outputs = JSON.parse(%x(swaymsg -t get_outputs))

pp output = outputs.find { |out| out['focused'] }

output_name = output['name']
output_scale = output['scale']

ALL_SCALES=[0.5, 1, 1.5, 2, 2.5, 3, 4]

def scale_mark scale, output_scale
  scale == output_scale ? " *" : ""
end

pp scale_texts = ALL_SCALES.map { |scale| [scale, scale_mark(scale, output_scale)].join('') }.join("\n")

title = "Choose scaling for #{output_name}"
scale = %x(echo "#{scale_texts}" | wofi -d -p "#{title}").strip

if scale == "" or scale.include?("*")
  # do nothing
else
  p cmd = %(swaymsg output #{output_name} scale #{scale})
  puts %x(#{cmd})
  notify "Set scaling on #{output_name} to #{scale}"
end
