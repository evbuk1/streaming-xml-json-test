#!/usr/bin/env ruby

# Usage:
#   ruby generate_dummy_xml.rb output.xml 10
#   Creates a ~10MB file named output.xml

require 'securerandom'

output_file = ARGV[0] || 'dummy.xml'
target_size_mb = (ARGV[1] || 10).to_f
target_size_bytes = target_size_mb * 1024 * 1024

puts "Generating #{target_size_mb} MB of dummy XML data into '#{output_file}'..."

def generate_record(id)
  <<~XML
    <record id="#{id}">
      <name>Item #{id}</name>
      <uuid>#{SecureRandom.uuid}</uuid>
      <description>This is a dummy description for item #{id}.</description>
      <value>#{rand(1000..9999)}</value>
      <timestamp>#{Time.now.utc.iso8601}</timestamp>
    </record>
  XML
end

File.open(output_file, 'w') do |f|
  f.puts '<?xml version="1.0" encoding="UTF-8"?>'
  f.puts '<records>'

  bytes_written = f.size
  record_id = 1

  while bytes_written < target_size_bytes
    record = generate_record(record_id)
    f.write(record)
    bytes_written += record.bytesize
    record_id += 1

    print "\rProgress: #{(bytes_written.to_f / target_size_bytes * 100).round(1)}%" if record_id % 100 == 0
  end

  f.puts "\n</records>"
end
