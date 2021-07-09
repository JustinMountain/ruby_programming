class Node
  attr_accessor :value, :left, :right
  def initialize(value=nil, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :array, :my_root, :unsorted, :sorted
  def initialize(array)
    @unsorted = array
    @sorted = array.sort!.uniq
    @my_root = build_tree(@sorted)
  end

  def build_tree(array)
    return nil if array.empty?
    midpoint = array.length / 2
    node = Node.new(array[midpoint])
    node.left = build_tree(array[0...midpoint])
    node.right = build_tree(array[midpoint + 1..-1])
    node
  end

  # Pretty Print method from the project
  def pretty_print(node = @my_root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

data_to_tree = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 6, 89, 12, 14]
my_tree = Tree.new(data_to_tree)
p my_tree.unsorted
p my_tree.sorted
p my_tree.my_root.value
my_tree.pretty_print