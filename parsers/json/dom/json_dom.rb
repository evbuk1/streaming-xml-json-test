require 'json'
require 'benchmark'

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

# === Main Program ===

input_file = 'input.json'
output_file = 'output.json'

GC.start
start_time = Time.now
start_mem = GC.stat(:total_allocated_memory)


data = JSON.parse(File.read(input_file))
updated_data = rename_key(data, old_key, new_key)
File.write(output_file, JSON.pretty_generate(updated_data))


GC.start # Run garbage collection again to clean up
end_time = Time.now
end_mem = GC.stat(:total_allocated_memory)

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{((end_mem - start_mem) / (1024.0 * 1024.0)).round(2)} MB"
