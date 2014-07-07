class Node
  attr_accessor :value, :left, :right

  def initialize(value = nil)
    @value = value
    @left  = nil
    @right = nil
  end

  def add_child(new_value)
    if @value.nil?
      @value = new_value
    else
      if new_value < @value
        @left.nil? ? @left = Node.new(new_value) : @left.add_child(new_value)
      elsif new_value > @value
        @right.nil? ? @right = Node.new(new_value) : @right.add_child(new_value)
      end
    end
  end

  def search(this_value)
    return false if @value.nil?
    return self.value if @value == this_value
    if this_value < @value
      @left.nil? ? false : @left.search(this_value)
    elsif this_value > @value
      @right.nil? ? false : @right.search(this_value)
    end
  end

  def rebalance(array)
    array.push(@value) if @value
    @left.rebalance(array) if @left
    @right.rebalance(array) if @right
    array
  end

  def display(string, level=1)
    header = ""
    level.times {header += '-'}

    if self.value
      string += "#{header.chop}#{self.to_s}\n"
    else
      string += "#{header.chop}nil\n"
    end

    if self.right
      string += self.right.display("", level + 1)
    end

    if self.left
      string += self.left.display("", level + 1)
    end

    string
  end

  def to_s
    # "Value: #{value}\n-- Right: #{right}\n-- Left: #{left}\n"
    "Value: #{value}"
  end
end
