class MyHash
  def initialize
    @pairs = Array.new(4) {[]}
    @counter = 0
  end

  def []=(key, value)
    resize_hash(@pairs.length * 2) if @counter >= @pairs.length/2
    index = find_index(key)
    @pairs[index].each do |pair|
      return pair[-1] = value if pair.first == key
    end
    @counter += 1
    @pairs[index].push( [key, value] )
  end

  def [](key)
    index = find_index(key)
    @pairs[index].each do |pair|
      return pair.last if pair.first == key
    end
    nil
  end

  def find_index(key)
    key.hash % @pairs.length
  end

  def resize_hash(new_size)
    old_pairs = @pairs
    @pairs = Array.new(new_size) {[]}
    @counter = 0

    old_pairs.each do |key_value_pairs|
      key_value_pairs.each do |pair|
        self[pair.first] = pair.last
      end
    end
  end
end
