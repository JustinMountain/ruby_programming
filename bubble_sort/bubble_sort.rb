# for each element in list, look at the element and the next one
  # if they are out of order, swap
# go through the array n - 1 times

def bubble_sort(numbers)
  max_iterations = numbers.length - 1
  current_iteration = 0
  is_sorted = false
  sorted_array = numbers

  until current_iteration == max_iterations
    sorted_array.each_with_index do |value, i|
      if sorted_array[i + 1] != nil
        if sorted_array[i] > sorted_array[i + 1]
          # switch them
          sorted_array[i] = sorted_array[i + 1]
          sorted_array[i + 1] = value
          is_sorted = false
        end
      end
    end
    current_iteration += 1
    if is_sorted == true
      current_iteration = max_iterations
    end
    is_sorted = true
  end
  p sorted_array
end

array_to_sort = [4,3,78,2,0,2]

bubble_sort(array_to_sort)