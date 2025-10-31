#!/usr/bin/env ruby

require 'nokogiri'
require 'get_process_mem'

class TransformHandler < Nokogiri::XML::SAX::Document
  def initialize(output_io)
    super()
    @output = output_io
    @current_element = nil
  end

  def start_document
    @output.puts('<?xml version="1.0" encoding="UTF-8"?>')
    @output.flush
  end

  def start_element(name, attrs = [])
    element_name = (name == 'instock' ? 'tickets_available' : name)

    @output.print("<#{element_name}>")
    @output.flush
    @current_element = element_name
  end

  def characters(string)
    return if string.strip.empty?
    @output.print(string)
    @output.flush
  end

  def end_element(name)
    element_name = (name == 'instock' ? 'tickets_available' : name)
    @output.print("</#{element_name}>")
    @output.flush
    @current_element = nil
  end

  def end_document
    @output.puts
    @output.flush
  end
end

if ARGV.length != 2
  puts "Usage: ruby sax_parser.rb input.xml output.xml"
  exit 1
end

input_file  = ARGV[0]
output_file = ARGV[1]

start_time = Time.now
mem = GetProcessMem.new
start_mem = mem.mb.round(2)

File.open(output_file, 'w') do |out|
  parser = Nokogiri::XML::SAX::Parser.new(TransformHandler.new(out))

  File.open(input_file, 'r') do |input|
    parser.parse(input)
  end
end

end_time = Time.now
end_mem  = mem.mb.round(2)

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{(end_mem - start_mem).round(2)} MB"
