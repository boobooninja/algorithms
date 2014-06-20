class Stack
  def initialize
    @array = [ ]
  end

  def push(value)
    @array.push(value)
  end

  def pop
    @array.pop
  end

  def length
    @array.length
  end
end
