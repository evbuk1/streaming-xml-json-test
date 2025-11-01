#!/usr/bin/env ruby

require 'nokogiri'
require 'get_process_mem'
require 'time'
require_relative '../../../processors/xml/sax/sax_event_parser'

if ARGV.length != 2
  puts "Usage: ruby xml_sax.rb input.xml output.xml"
  exit
end

input_file, output_file = ARGV

start_time = Time.now
mem = GetProcessMem.new
start_mem = mem.mb.round(2)

File.open(output_file, 'w') do |out|
  parser = Nokogiri::XML::SAX::Parser.new(SaxEventParser.new(out))

  File.open(input_file, 'r') do |input|
    parser.parse(input)
  end
end

end_time = Time.now
end_mem  = mem.mb.round(2)

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{(end_mem - start_mem).round(2)} MB"
