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
output_transform = output['transform']

ALL_TRANSFORMS=%w(90 180 270 flipped flipped-90 flipped-180 flipped-270 normal)

def mark_transform transform, output_transform
  transform == output_transform ? " *" : ""
end

pp scale_texts = ALL_TRANSFORMS.map { |transform| [transform, mark_transform(transform, output_transform)].join('') }.join("\n")

title = "Choose transform/rotation for #{output_name}"
transform = %x(echo "#{scale_texts}" | wofi -d -p "#{title}").strip

if transform == "" or transform.include?("*")
  # do nothing
else
  p cmd = %(swaymsg output #{output_name} transform #{transform})
  puts %x(#{cmd})
  notify "Set transform on #{output_name} to #{transform}"
end
