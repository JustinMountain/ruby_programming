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

  def my_all?
    all_true = true
    self.my_each { |var| all_true = false unless yield var }
    return all_true
  end

  def my_any?
    any_true = false
    self.my_each { |var| any_true = true if yield var }
    return any_true
  end

  def my_none?
    none_true = true
    self.my_each { |var| none_true = false if yield var }
    return none_true
  end

  def my_count
    count = 0
    block_given? ? self.my_each { |var| count += 1 if yield var } : count = length
    return count
  end

  def my_map(proc=nil)
    return_array = []
    if proc == nil
      self.my_each { |var| return_array << (yield var) }
    elsif proc.is_a? Proc
      self.my_each { |var| return_array << proc.call(var) }
    else
      puts "ERROR: Not a valid argument for .my_map"  
    end
    return return_array
  end

  def my_inject(memo=nil, possible_symbol=nil)
    if memo == nil
      injected = self[0]
    elsif memo.is_a? Symbol
      possible_symbol = memo
      injected = self[0]
    else
      injected = memo
    end

    if possible_symbol == :+
      self.my_each_with_index do |var, index| 
        next if (memo == nil || memo.is_a?(Symbol)) && index == 0
        injected += var
      end
    elsif possible_symbol == :-
      self.my_each_with_index do |var, index| 
        next if (memo == nil || memo.is_a?(Symbol)) && index == 0
        injected -= var
      end
    elsif possible_symbol == :*
      self.my_each_with_index do |var, index| 
        next if (memo == nil || memo.is_a?(Symbol)) && index == 0
        injected *= var
      end
    elsif possible_symbol == :/
      self.my_each_with_index do |var, index| 
        next if (memo == nil || memo.is_a?(Symbol)) && index == 0
        injected /= var
      end
    elsif possible_symbol == nil
      self.my_each_with_index do |var, index| 
        next if (memo == nil || memo.is_a?(Symbol)) && index == 0
        injected = yield(var, injected)
      end
    else possible_symbol != nil
      puts "ERROR: Not a valid argument for .my_inject"  
    end
    return injected
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

# my_all? test
# puts numbers.my_all?  { |num| num.is_a? Integer }
# puts " "
# puts numbers.all?  { |num| num.is_a? Integer }

# my_any? test
# puts numbers.my_any?  { |num| num == 6 }
# puts " "
# puts numbers.any?  { |num| num == 6 }

# my_none? test
# puts numbers.my_none?  { |num| num == 2 }
# puts " "
# puts numbers.none?  { |num| num == 2 }

# my_count test
# puts numbers.my_count  { |num| num.is_a? String }
# puts numbers.my_count
# puts " "
# puts numbers.count  { |num| num.is_a? String }

# my_map test
my_proc = Proc.new { |num| num * 2 }

p numbers.my_map(my_proc)
p numbers.my_map { |num| num * 2 }
puts " "
p numbers.map { |num| num * 2 }

# my_inject test
# p numbers.my_inject { |num, i| num * i}
# puts " "
# p numbers.inject { |num, i| num * i}

# def multiply_els(array)
#   array.my_inject { |var, injector| var *= injector }
# end
# puts multiply_els([2, 4, 5])