#!/usr/bin/env ruby

require 'nokogiri'
require 'get_process_mem'
require 'time'

if ARGV.length != 2
  puts "Usage: ruby xml_reader.rb input_file.xml output_file.xml"
  exit
end

input_file, output_file = ARGV

mem = GetProcessMem.new
start_mem = mem.mb.round(2)
start_time = Time.now

File.open(output_file, 'w') do |out|
  out.puts '<?xml version="1.0" encoding="UTF-8"?>'

  reader = Nokogiri::XML::Reader(File.open(input_file))

  reader.each do |node|
    case node.node_type
    when Nokogiri::XML::Reader::TYPE_ELEMENT
      element_name = node.name == 'instock' ? 'tickets_available' : node.name
      out.puts "<#{element_name}>"
    when Nokogiri::XML::Reader::TYPE_END_ELEMENT
      element_name = node.name == 'instock' ? 'tickets_available' : node.name
      out.puts "</#{element_name}>"
    when Nokogiri::XML::Reader::TYPE_TEXT
      text = node.value.strip
      out.puts text unless text.empty?
    when Nokogiri::XML::Reader::TYPE_CDATA
      text = node.outer_xml
      out.puts text unless text.empty?
    end
  end
end

end_time = Time.now
end_mem  = mem.mb.round(2)

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{(end_mem - start_mem).round(2)} MB"