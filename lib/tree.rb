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

    @head = Node.new

    # mid = array.length / 2
    # first = array[0...mid]
    # second = array[mid+1..-1]
    # longest = first.length > second.length ? first.length : second.length

    # self.add_node(mid)

    split_array(array)

    # longest.times do |num|
    #   add_node(first[num]) if first[num]
    #   add_node(second[num]) if second[num]
    # end

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
