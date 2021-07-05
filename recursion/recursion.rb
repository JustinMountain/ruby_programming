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

def merge_sort
  # code goes here
end