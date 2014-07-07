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

  def display(string, level=0)
    return '' if @value.nil?
    header = ''
    level.times {header += '-'}

    string += "#{header.chop} #{@value}\n"
    if @right
      string += "#{header} #{@right.display('', level + 1)}\n"
    else
      string += "#{header} nil\n"
    end
    if @left
      string += "#{header} #{@left.display('', level + 1)}\n"
    else
      string += "#{header} nil\n"
    end

    string
  end
end
