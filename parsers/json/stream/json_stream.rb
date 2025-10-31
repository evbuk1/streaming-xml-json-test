#!/usr/bin/env ruby

require 'oj'
require 'get_process_mem'

if ARGV.length != 2
  puts "Usage: ruby json_stream.rb input.xml output.xml"
  exit 1
end

input_path, output_path = ARGV

mem = GetProcessMem.new
start_mem = mem.mb.round(2)

class EventParser < ::Oj::Saj
  def initialize(output_io)
    @output = output_io
  end

  def hash_start(key)
    @output.print('{')
    @output.flush
  end

  def hash_end(key)
    @output.print('}')
    @output.flush
  end

  def array_start(key)
    @output.print('[')
    @output.flush
  end

  def array_end(key)
    @output.print(']')
    @output.flush
  end

  def add_value(value, key)
    @output.print("\"#{key}\": \"#{value}\",")
    @output.flush
  end
end

output = File.open(output_path, 'w')
handler = EventParser.new(output)
File.open(input_path, 'r') do |input|
    Oj.saj_parse(handler, input)
end

output.close

end_mem = mem.mb.round(2)

puts "Memory used: #{(end_mem - start_mem).round(2)} MB"