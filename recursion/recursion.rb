# Iterative Fibonacci
def fibs(position)
  fib_array = []
  n = 0
  until position == 0
    n == 0 || n == 1 ? fib_array.push(n) : fib_array.push(fib_array[n - 1] + fib_array[n - 2])
    n += 1
    position -= 1
  end
  return fib_array
end

p fibs(10)

# Recursive Fibonacci
def fibs_rec(position)
  return [0] if position == 1
  return [0, 1] if position == 2

  fib_array = fibs_rec(position - 1)
  fib_array << fib_array[-2] + fib_array[-1]
end

p fibs_rec(10)

def merge_sort(array)
  # Base Case
  return array if array.length < 2

  half = array.length / 2
  left = merge_sort(array.slice(0...half))
  right = merge_sort(array.slice(half..-1))

  combine(left, right)
end

def combine(left_array, right_array)
  merge = []
  left_array = left_array
  right_array = right_array

  until left_array.empty? || right_array.empty?
    if left_array.first < right_array.first
      merge << left_array.shift
    elsif right_array.first < left_array.first
      merge << right_array.shift
    else
      merge << left_array.shift
      merge << right_array.shift
    end
  end
  
  return merge + left_array + right_array
end

p merge_sort([5, 2, 1, 3, 6, 4, 3, 9, 7, 1, 8, 10])