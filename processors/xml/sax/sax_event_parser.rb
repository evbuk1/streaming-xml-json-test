class SaxEventParser < Nokogiri::XML::SAX::Document
  def initialize(output_io)
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
    @output.print(string)
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