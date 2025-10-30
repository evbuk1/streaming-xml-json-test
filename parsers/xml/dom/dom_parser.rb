require 'nokogiri'
require 'securerandom'
require 'time'

if ARGV.length != 2
  puts "Usage: ruby dom_parser.rb input_file.xml output_file.xml"
  exit
end

input_file = ARGV[0]
output_file = ARGV[1]

GC.start
start_time = Time.now
start_mem = GC.stat(:total_allocated_memory)

xml_content = File.read(input_file)

doc = Nokogiri::XML(xml_content)

doc.xpath('//event/instock').each do |desc_node|
  new_node = Nokogiri::XML::Node.new('tickets_available', doc)
  new_node.content = desc_node.content
  desc_node.replace(new_node)
end

File.open(output_file, 'w') { |file| file.write(doc.to_xml) }

GC.start
end_time = Time.now
end_mem = GC.stat(:total_allocated_memory)

puts "Total time taken: #{(end_time - start_time).round(2)} seconds"
puts "Memory used: #{((end_mem - start_mem) / (1024.0 * 1024.0)).round(2)} MB"
