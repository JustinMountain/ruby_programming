class LinkedList
  attr_accessor :head, :tail, :length

  def initialize
    @length = 0
    @tail = Node.new()

    @head = Node.new(nil, @tail)
  end

  def print_list
    current = @head

    position = @length
    until position == 0
      p current.value
      current = current.next_node
      position -= 1
    end
  end

  def append(value)
    if @tail.value == nil
      @tail.value = value
    else
      old_tail = @tail
      @tail = Node.new(value)
      old_tail.next_node = @tail
    end
    @length += 1
  end

  def prepend(value)
    if @head.value == nil
      @head.value = value
    else
      old_head = @head
      @head = Node.new(value, old_head)
    end
    @length += 1
  end

  def size
    return @length
  end

  def head
    return @head.value
  end

  def tail
    return @tail.value
  end

  def at(position)
    current = @head
    position.times { current = current.next_node }
    return current.value
  end

  def pop
    popped = @tail
    new_tail = @head

    (@length - 2).times { new_tail = new_tail.next_node }
    new_tail.next_node = nil
    @tail = new_tail
    @length -= 1
    return popped.value
  end

  def contains?(value)
    exists = false
    exists = true if (value == @head.value)

    current = @head
    (@length - 1).times do 
      current = current.next_node
      exists = true if (value == current.value)
    end
    return exists
  end

  def find(value)
    index = 0 
    if self.contains?(value) == false
      puts "#{value} was not in the linked list."
      return nil
    else
      found = false
      current = @head
      (@length - 1).times do 
        current = current.next_node
        found = true if (value == current.value)
        index += 1
        break if found == true
      end
      return index
    end
  end

  def to_s
    string = ""
    pointer = @head
    (@length - 1).times do
      string << "( " + pointer.value.to_s + " ) -> "
      pointer = pointer.next_node
    end
    string << "( " + pointer.value.to_s + " ) -> nil"
    return string
  end

  def insert_at(value, index)
    node = Node.new(value)
    pointer = @head
    if index > 0
      (index - 1).times { pointer = pointer.next_node }
      node.next_node = pointer.next_node
      pointer.next_node = node
      @length += 1
    elsif index == 0
      self.prepend(value)
    else
      puts "Can't insert at a negative index position"
    end
  end

  def remove_at(index)
    if index < @length && index > -1
      pointer = @head
      if index > 0
        (index - 1).times { pointer = pointer.next_node }
        pointer.next_node = pointer.next_node.next_node
        @length -= 1
      elsif index == @length - 1
        self.pop
      elsif index == 0
        @head = pointer.next_node
        @length -= 1
      else
        puts "Can't remove at a negative index position"
      end  
    else
      puts "There's no node at that index"
    end
  end
end

class Node

  attr_accessor :next_node, :value

  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

list_test = LinkedList.new()

# Append and Prepend testing
list_test.append("second node")
list_test.append("third node")
list_test.prepend("first node")
list_test.append("fourth node")
list_test.prepend("real first node")

# # Head, Tail, and Size testing
# list_test.print_list
# puts list_test.size
# puts list_test.head
# puts list_test.tail
# puts list_test.at(4) # 4 is the tail, position in RAM should print identically to above

# # Pop testing and comparisons
# puts list_test.pop
# list_test.print_list
# puts list_test.size
# puts list_test.at(3) # 3 is the new tail, position in RAM should print identically to above
# puts list_test.tail # Should match above

# # Contains testing
# puts list_test.contains?("first node")
# puts list_test.contains?("fourth node")

# # Find testing
# puts list_test.at(2)
# puts list_test.contains?("second node")
# puts list_test.find("second node")

# # to_s testing
# puts list_test.to_s

# # insert_at and remove_at testing
# list_test.print_list
# puts "---"
# list_test.insert_at("inserted", 2)
# list_test.print_list
# puts "---"
# list_test.remove_at(2)
# list_test.remove_at(0)
# list_test.print_list