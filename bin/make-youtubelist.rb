#!/usr/bin/env ruby

args = ARGV.clone

if args.empty?
  puts "Paste youtube urls here, one line per url, empty line ends input:"
  while !(input = gets.chomp).empty?
    args.push(input)
  end
end

video_ids = args.map do |urlish|
  urlish =~ /watch?.*v=([^&]+)/ && $1 or urlish
end

BASE_URL = %(https://youtube.com/watch_videos?video_ids=%s)

puts %(This link should get you to your new anonymous playlist:), BASE_URL % video_ids.join(",")
