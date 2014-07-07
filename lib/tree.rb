class Tree
  attr_accessor :head

  def initialize
    @head = Node.new
  end

  def add_node(value)
    @head.add_child(value)
  end

  def search(value)
    @head.search(value)
  end

  def rebalance
    array = []
    @head.rebalance(array)
    array.sort!
    mid = array.length / 2
    first = array[0...mid].reverse
    second = array[mid..-1]
    longest = first.length > second.length ? first.length : second.length

    @head = Node.new
    longest.times do |num|
      add_node(first[num]) if first[num]
      add_node(second[num]) if second[num]
    end

    self
  end

  def display
    string = @head.display("")
    puts string
  end
end
