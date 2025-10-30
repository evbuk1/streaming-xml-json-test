#!/usr/bin/env ruby

require 'nokogiri'

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
    @output.print(Nokogiri::XML::Text.new(string, nil).to_s)
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

if ARGV.length < 2
  puts "Usage: ruby sax_parser.rb input.xml output.xml"
  exit 1
end

input_file  = ARGV[0]
output_file = ARGV[1]

GC.start
start_time = Time.now
start_mem = GC.stat[:total_allocated_mem]

File.open(output_file, 'w') do |out|
  parser = Nokogiri::XML::SAX::Parser.new(TransformHandler.new(out))

  File.open(input_file, 'r') do |input|
    parser.parse(input)
  end
end

GC.start
end_time = Time.now
end_mem  = GC.stat[:total_allocated_mem]
elapsed = end_time - start_time

puts "Time taken: #{elapsed.round(3)} seconds"
puts "Memory used: #{((end_mem - start_mem) / (1024.0 * 1024.0)).round(2)} MB"
