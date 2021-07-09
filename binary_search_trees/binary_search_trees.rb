class Node
  attr_accessor :value, :left, :right
  def initialize(value=nil, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :array
  def initialize(array)
    @unsorted = array
    @array = @unsorted.sort!.uniq
  end
end

data_to_tree = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_tree = Tree.new(data_to_tree)
p my_tree.array
