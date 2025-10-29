#!/usr/bin/env ruby

require 'json'
require 'securerandom'

# Usage: ruby generate_dummy_json.rb <output_file> <size_in_mb>

output_file = ARGV[0] || "dummy.json"
target_mb   = (ARGV[1] || 10).to_f
target_bytes = (target_mb * 1024 * 1024).to_i

puts "Generating #{target_mb} MB of dummy JSON data in '#{output_file}'..."

File.open(output_file, 'w') do |file|
  file.write("[\n")  # Start JSON array
  size = 2  # Start with 2 bytes for '[' and '\n'
  first = true

  while size < target_bytes
    obj = {
      id: SecureRandom.uuid,
      name: "User_#{rand(100000)}",
      email: "user#{rand(100000)}@example.com",
      active: [true, false].sample,
      balance: rand * 10000,
      tags: Array.new(5) { SecureRandom.hex(4) },
      metadata: {
        created_at: Time.now.iso8601,
        updated_at: Time.now.iso8601,
        note: SecureRandom.alphanumeric(50)
      }
    }

    json_str = JSON.generate(obj)
    json_str = ",\n" + json_str unless first
    first = false

    file.write(json_str)
    size += json_str.bytesize
  end

  file.write("\n]\n")  # Close JSON array
end