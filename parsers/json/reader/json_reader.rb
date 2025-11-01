#!/usr/bin/env ruby

require 'json'
require 'time'
require 'get_process_mem'
require 'yajl'

# Usage: ruby process_json.rb input.json output.json old_key new_key
if ARGV.length != 2
  puts "Usage: ruby json_reader.rb input.json output.json"
  exit 1
end

input_file, output_file = ARGV

mem = GetProcessMem.new
start_mem = mem.mb.round(2)

start_time = Time.now

File.open(input_file, 'r') do |infile|
  File.open(output_file, 'w') do |outfile|
    outfile.write("[")
    first = true

    parser = Yajl::Parser.new

    parser.on_parse_complete = proc do |object|
      if object.is_a?(Hash)
        if object.key?('eventName')
          object['nameOfEvent'] = object.delete('eventName')
        end
      end

      outfile.write(",") unless first
      first = false

      Yajl::Encoder.encode(object, outfile)
    end

    buffer = ""
    depth = 0
    inside_array = false

    infile.each_char do |ch|
      case ch
      when '['
        if !inside_array
          inside_array = true
          next
        end
      when ']'
        if depth == 0
          break
        end
      when '{'
        depth += 1
      when '}'
        depth -= 1
      end
      buffer << ch

      if depth == 0 && !buffer.strip.empty?
        buffer = buffer.chomp(',')
        parser.parse(buffer)
        buffer.clear
      end
    end

    outfile.write("]")
  end
end

end_mem = mem.mb.round(2)
end_time = Time.now

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{(end_mem - start_mem).round(2)} MB"