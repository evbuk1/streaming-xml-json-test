#!/usr/bin/env ruby

require 'oj'
require 'get_process_mem'
require_relative '../../../processors/json/saj/saj_event_parser'

if ARGV.length != 2
  puts "Usage: ruby json_stream.rb input.json output.json"
  exit 1
end

input_file, output_file = ARGV

mem = GetProcessMem.new
start_mem = mem.mb.round(2)
start_time = Time.now

output = File.open(output_file, 'w')

handler = SajEventParser.new(output)

File.open(input_file, 'r') do |input|
    Oj.saj_parse(handler, input)
end

output.close

end_mem = mem.mb.round(2)
end_time = Time.now

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{(end_mem - start_mem).round(2)} MB"