class ReaderEventParser
  def initialize(parser, infile)
    @parser = parser
    @infile = infile
  end

  def process_each_event
    buffer = ""
    depth = 0
    inside_array = false

    @infile.each_char do |ch|
      case ch
      when '['
        unless inside_array
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
        @parser.parse(buffer)
        buffer.clear
      end
    end
  end
end
