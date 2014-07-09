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

  def add_child_iterative(new_value)
    if @value.nil?
      @value = new_value
    else
      if new_value < @value
        this_child = @left
        direction  = :left
      elsif new_value > @value
        this_child = @right
        direction  = :right
      end

      if this_child.nil?
        self.send("#{direction}=", Node.new(new_value))
      else
        begin
          if this_child.value.nil?
            this_child.value = new_value
          else
            this_child = this_child.send(direction)
          end
        end while this_child.value.nil?
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

  def search_iterative(this_value)
    this_node = self
    begin
      return false if this_node.value.nil?
      return this_node.value if this_node.value == this_value

      if this_value < this_node.value
        this_node = this_node.left

        return false if this_node.nil?
      elsif this_value > this_node.value
        this_node = this_node.right

        return false if this_node.nil?
      end
    end while this_node
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
