module Sort
  def self.selection_sort(array)
    for i in 0..array.length - 2
      min = i
      for j in i+1..array.length - 1
        min = j if array[j] < array[min]
      end
      array[i], array[min] = array[min], array[i]
    end
    array
  end
end
