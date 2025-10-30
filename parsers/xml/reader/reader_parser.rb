#!/usr/bin/env ruby
require 'nokogiri'

if ARGV.length < 2
  warn "Usage: ruby reader_parser.rb INPUT_FILE OUTPUT_FILE"
  exit 1
end

input_file, output_file = ARGV

GC.start
start_time = Time.now
start_mem = GC.stat[:total_allocated_mem]

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

GC.start
end_time = Time.now
end_mem  = GC.stat[:total_allocated_mem]
elapsed = end_time - start_time

puts "Time taken: #{elapsed.round(3)} seconds"
puts "Memory used: #{((end_mem - start_mem) / (1024.0 * 1024.0)).round(2)} MB"