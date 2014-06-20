module Sort
  def self.selection_sort(array)
    length = array.length

    array.each_with_index do |num,i|
      pointer = 1

      while pointer < length do
        if num > array[pointer]
          array[i], array[pointer] = array[pointer], array[i]
        end
        pointer += 1
      end
    end

    array
  end
end
