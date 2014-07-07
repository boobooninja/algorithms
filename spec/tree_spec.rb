require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'

describe 'Tree' do
  it "exists" do
    expect(Tree).to be_a(Class)
  end

  it "initializes and sets :head to a new node with nil value" do
    tree = Tree.new

    expect(tree).to be_a(Tree)
    expect(tree.head).to be_a(Node)
    expect(tree.head.value).to eq(nil)
  end

  context "responds to add_node(value)" do
    it "when it's value is nil by setting it's value" do
      tree = Tree.new
      expect(tree.add_node(1)).to eq(1)
      expect(tree.head.value).to eq(1)
    end

    it "when it's value is greater than the value to add a right node" do
      tree = Tree.new
      expect(tree.add_node(5)).to eq(5)
      expect(tree.head.value).to eq(5)
      expect(tree.add_node(3)).not_to eq(5)
      expect(tree.head.left).to be_a(Node)
      expect(tree.head.left.value).to eq(3)
      expect(tree.head.right).to eq(nil)
    end

    it "when it's value is lesser than the value to add a left node" do
      tree = Tree.new
      expect(tree.add_node(5)).to eq(5)
      expect(tree.head.value).to eq(5)
      expect(tree.add_node(7)).not_to eq(5)
      expect(tree.head.left).to eq(nil)
      expect(tree.head.right).to be_a(Node)
      expect(tree.head.right.value).to eq(7)
    end
  end

  context "responds to search(value)" do
    it "returns the value when it is found" do
      tree = Tree.new
      tree.add_node(5)
      tree.add_node(10)
      tree.add_node(3)

      expect(tree.search(3)).to eq(3)
    end

    it "returns false when it is not found" do
      tree = Tree.new
      tree.add_node(5)
      tree.add_node(10)
      tree.add_node(3)

      expect(tree.search(4)).to eq(false)
    end
  end

  it "responds to rebalance by rebalancing the nodes" do
    tree = Tree.new
    tree.add_node(1)
    tree.add_node(2)
    tree.add_node(3)
    tree.add_node(4)
    tree.add_node(5)
    tree.add_node(6)
    tree.add_node(7)

    expect(tree.head.left).to eq(nil)
    expect(tree.head.right.value).to eq(2)
    expect(tree.head.right.right.value).to eq(3)

    tree.rebalance

    expect(tree.head.value).to eq(4)
    expect(tree.head.left).to be_a(Node)
    expect(tree.head.right).to be_a(Node)

    expect(tree.head.left.left).to be_a(Node)
    expect(tree.head.right.right).to be_a(Node)

    expect(tree.head.left.right).to be_a(Node)
    expect(tree.head.right.left).to be_a(Node)
  end
end
