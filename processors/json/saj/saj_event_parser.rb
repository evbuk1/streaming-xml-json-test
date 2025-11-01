class SajEventParser < ::Oj::Saj
  def initialize(output_io)
    @output = output_io
    @stack = []
  end

  def hash_start(_key)
    @stack.push(:hash_first)
    @output.print('{')
    @output.flush
  end

  def hash_end(_key)
    @stack.pop
    @output.print('}')
    @output.flush
  end

  def array_start(_key)
    @stack.push(:array_first)
    @output.print('[')
    @output.flush
  end

  def array_end(_key)
    @stack.pop
    @output.print(']')
    @output.flush
  end

  def add_value(val, key)
    key = key == 'eventName' ? 'nameOfEvent' : key

    write_comma_if_needed
    @stack[-1] = :hash_next
    @output.print(Oj.dump(key))
    @output.print(':')
    @output.print(Oj.dump(val))
    @output.flush
    update_state_after_value
  end

  def write_comma_if_needed
    return if @stack.empty?
    top = @stack.last
    if top == :hash_next || top == :array_next
      @output.print(',')
    end
  end

  def update_state_after_value
    if @stack.last == :hash_first
      @stack[-1] = :hash_next
    elsif @stack.last == :array_first
      @stack[-1] = :array_next
    end
  end
end