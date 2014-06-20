require_relative 'queue'

describe 'Node' do
  it "exists" do
    expect(Node).to be_a(Class)
  end

  it "is a kind of Array" do
    expect(Node.new(0)).to be_a_kind_of(Array)
  end

  it "responds to value" do
    expect(Node.new(1).value).to eq(1)
  end

  it "responds to pointer" do
    expect(Node.new(1).value).to eq(1)
  end

  it "responds to pointer=(value) by setting the pointer" do
    node = Node.new(1)
    node.pointer = 2
    expect(node.pointer).to eq(2)
  end
end

describe 'Queue' do
  before(:each) do
    @queue = Queue.new
    @node1 = Node.new(1)
    @node2 = Node.new(2)
  end

  it "exists" do
    expect(Queue).to be_a(Class)
  end

  it "responds to push(node) by putting the node on the end of the chain" do
    @queue.push(@node1)
    expect(@queue.peek).to eq(@node1)
  end

  it "responds to shift by removing and returning the first node" do
    @queue.push(@node1)
    @queue.push(@node2)
    expect(@queue.shift).to eq(@node1)
    expect(@queue.peek).to eq(@node2)
  end

  it "responds to peek by returning the first node" do
    @queue.push(@node1)
    @queue.push(@node2)
    expect(@queue.peek).to eq(@node1)
  end
end
