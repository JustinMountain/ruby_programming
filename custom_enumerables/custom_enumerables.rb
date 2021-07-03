module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    return_array = []
    self.my_each { |var| return_array << var if yield var }
    return return_array
  end
end

numbers = [1, 2, 3, 4, 5]
# my_each test
# numbers.my_each  { |item| puts item }
# puts " "
# numbers.each  { |item| puts item }

# my_each_with_index test
# numbers.my_each_with_index  { |item, index| puts "[#{index}]: #{item}" }
# puts " "
# numbers.each_with_index  { |item, index| puts "[#{index}]: #{item}" }

# my_select test
# puts numbers.my_select  { |num| num.even? }
# puts " "
# puts numbers.select  { |num| num.even? }
