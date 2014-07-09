class Tree
  attr_accessor :head

  def initialize
    @head = Node.new
  end

  def add_node(value)
    @head.add_child(value)
  end

  def add_node_iterative(value)
    @head.add_child_iterative(value)
  end

  def search(value)
    @head.search(value)
  end

  def search_iterative(value)
    @head.search_iterative(value)
  end

  def rebalance
    array = []
    @head.rebalance(array)
    array.sort!

    @head = Node.new

    split_array(array)

    self
  end

  def split_array(array)
    unless array.empty?
      mid = array.length / 2
      first = array[0...mid]
      second = array[mid+1..-1]

      add_node(array[mid]) if array[mid]
      split_array(first)
      split_array(second)
    end
  end

  def display
    string = @head.display("")
    puts string
  end
end
