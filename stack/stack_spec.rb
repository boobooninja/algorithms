require_relative 'stack'

describe 'Stack' do
  it "exists" do
    expect(Stack).to be_a(Class)
  end

  it "responds to push given a value by adding it to the stack" do
    expect(Stack.new.push(1).length).to eq(1)
  end

  it "responds to pop by removing the last item off the stack" do
    stack = Stack.new
    stack.push(1)
    expect(stack.length).to eq(1)
    expect(stack.pop).to eq(1)
    expect(stack.length).to eq(0)
  end
end
