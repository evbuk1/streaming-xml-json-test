require 'nokogiri'
require 'securerandom'
require 'time'

if ARGV.length != 2
  puts "Usage: ruby dom_parser.rb input_file.xml output_file.xml"
  exit
end

input_file = ARGV[0]
output_file = ARGV[1]

start_time = Time.now
start_memory = memory_usage_mb

xml_content = File.read(input_file)

doc = Nokogiri::XML(xml_content)

doc.xpath('//record/description').each do |desc_node|
  new_node = Nokogiri::XML::Node.new('event_details', doc)
  new_node.content = desc_node.content
  desc_node.replace(new_node)
end

File.open(output_file, 'w') { |file| file.write(doc.to_xml) }

end_time = Time.now
end_memory = memory_usage_mb

puts "Time taken: #{(end_time - start_time).round(3)} seconds"
puts "Memory used: #{(end_memory - start_memory).round(3)} MB"
