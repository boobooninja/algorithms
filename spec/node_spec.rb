require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'

describe 'Node' do
  it "exists" do
    expect(Node).to be_a(Class)
  end

  it "initializes and sets :value, :left, :right default to nil" do
    node = Node.new

    expect(node).to be_a(Node)
    expect(node.value).to eq(nil)
    expect(node.left).to eq(nil)
    expect(node.right).to eq(nil)
  end
end
