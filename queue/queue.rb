class Node < Array
  def initialize(value)
    this = super()
    this << value
    this << nil
  end

  def value
    self[0]
  end

  def pointer
    self[1]
  end

  def pointer=(value)
    self[1] = value
  end
end

class Queue
  def initialize
    @nodes = { }
    @first = nil
    @last  = nil
  end

  def push(node)
    if (@last)
      @nodes[ @last ].pointer = node.value
      @nodes[ node.value ] = node
      @last = node.value
    else
      @nodes[ node.value ] = node
      @first = node.value
      @last = node.value
    end
  end

  def shift
    this_node = @nodes[ @first ]
    @nodes.delete(@first)
    @first = @nodes[ this_node.pointer ].value
    this_node
  end

  def peek
    @nodes[ @first ]
  end
end
