#!/usr/bin/env ruby
require 'yajl'

if ARGV.length != 2
  puts "Usage: ruby json_stream.rb <input_file> <output_file>"
  exit 1
end

input_file  = ARGV[0]
output_file = ARGV[1]

start_time = Time.now
GC.start
start_mem = GC.stat(:total_allocated_memory)

def rename_tags(data)
  case data
  when Array
    data.map { |item| rename_tags(item) }
  when Hash
    data.each_with_object({}) do |(k, v), new_hash|
      new_key = (k == 'eventName') ? 'nameOfEvent' : k
      new_hash[new_key] = rename_tags(v)
    end
  else
    data
  end
end

File.open(input_file, 'r') do |in_file|
  File.open(output_file, 'w') do |out_file|
    encoder = Yajl::Encoder.new(out_file)
    parser  = Yajl::Parser.new(symbolize_keys: false)

    parser.on_parse_complete = lambda do |obj|
      renamed_obj = rename_tags(obj)
      encoder.encode(renamed_obj)
    end

    parser.parse(in_file)
  end
end

end_time = Time.now
end_mem = GC.stat(:total_allocated_memory)

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{((end_mem - start_mem) / (1024.0 * 1024.0)).round(2)} MB"
