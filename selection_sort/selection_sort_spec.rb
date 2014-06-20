require 'rubygems'
require 'rspec'
require_relative 'selection_sort'

describe 'Sort' do
  describe '.selection_sort' do

    context 'when the argument is empty' do
      it "returns an empty array" do
        expect(Sort.selection_sort([])).to eq([])
      end
    end

    context 'when the argument has negative numbers' do
      it "sorts them appropriately" do
        expect(Sort.selection_sort([4,1,-2])).to eq([-2,1,4])
      end
    end

    context "when the argument contains duplicate numbers" do
      it "sorts the first before the last" do
        expect(Sort.selection_sort([4,2,7,2])).to eq([2,2,4,7])
      end
    end

    context "when the argument is a large unordered array" do
      it "sorts them appropriately from small to large" do
        unsorted = [9,3,6,1,3,0,6,4,5,1,22,45,12,33,99,56,73]
        sorted   = [0, 1, 1, 3, 3, 4, 5, 6, 6, 9, 12, 22, 33, 45, 56, 73, 99]
        expect(Sort.selection_sort(unsorted)).to eq(sorted)
      end
    end
  end
end
