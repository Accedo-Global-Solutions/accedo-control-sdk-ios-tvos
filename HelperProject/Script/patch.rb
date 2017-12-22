#!/usr/bin/env ruby
ARGV.each do |value|
  puts value
  f = File.open(value, "r") 
  data = ''
  f.each_line do |line|
     if (line.index("l#if") == 0) 
        data+=line[1..-1]
      else
        data+=line
      end 
  end
  File.write(value, data)
end