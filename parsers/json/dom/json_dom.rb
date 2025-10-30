require 'json'
require 'benchmark'
require 'objspace'

def rename_key(obj, old_key, new_key)
  case obj
  when Array
    obj.map { |item| rename_key(item, old_key, new_key) }
  when Hash
    obj.each_with_object({}) do |(k, v), new_hash|
      new_key_name = (k == old_key) ? new_key : k
      new_hash[new_key_name] = rename_key(v, old_key, new_key)
    end
  else
    obj
  end
end

if ARGV.length != 2
  puts "Usage: ruby json_dom.rb <input.json> <output.json>"
  exit 1
end

input_file, output_file = ARGV

start_time = Time.now
start_mem = ObjectSpace.memsize_of_all

data = JSON.parse(File.read(input_file))
updated_data = rename_key(data, 'eventName', 'nameOfEvent')
File.write(output_file, JSON.pretty_generate(updated_data))

end_time = Time.now
end_mem = ObjectSpace.memsize_of_all

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{((end_mem - start_mem) / (1024.0 * 1024.0)).round(2)} MB"
