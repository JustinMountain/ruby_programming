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

  def insert(value, node=@my_root)
    return nil if @unsorted.include?(value)
    if value < node.value
      node.left == nil ? node.left = Node.new(value) : insert(value, node.left) 
    elsif value > node.value
      node.right == nil ? node.right = Node.new(value) : insert(value, node.right)  
    end
  end

  def delete(value, node=@my_root)
    return nil unless @unsorted.include?(value)
    # First I need to find the node to delete
    node = @my_root
    if node.value == value 
      has_children = node
    else
      until node.left.value == value || node.right.value == value
        if value < node.value
          node = node.left
        elsif value > node.value
          node = node.right
        end
      end
      # Check for status of children
      node.left.value == value ? has_children = node.left : has_children = node.right
    end
    if has_children.left && has_children.right
      has_children = 2
    elsif has_children.left || has_children.right
      has_children = 1
    else 
      has_children = 0
    end
    puts "#{has_children} child(ren)."

    # value is a leaf
    if has_children == 0
      node.left.value == value ? node.left = nil : node.right = nil

    # value has one child
    elsif has_children == 1
      if node.left.value == value
        grandchild = node.left
        grandchild.left == nil ? grandchild = grandchild.right : grandchild = grandchild.left  
        node.left = grandchild
      else
        grandchild = node.right
        grandchild.left == nil ? grandchild = grandchild.right : grandchild = grandchild.left  
        node.right = grandchild
      end
    
    # value has two children
    else 

    end
  end

  # Pretty Print method from the project
  def pretty_print(node = @my_root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

data_to_tree = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_tree = Tree.new(data_to_tree)
p my_tree.unsorted
p my_tree.sorted
p my_tree.my_root.value
my_tree.pretty_print

# # Insert Testing
# my_tree.insert(9999)
# my_tree.insert(999)
# my_tree.insert(99)
# my_tree.insert(97)
# my_tree.insert(98)
# my_tree.insert(95)

# my_tree.pretty_print

# Delete Testing
  # 0 children
my_tree.delete(5)

  # 1 child
my_tree.delete(23)

  # 2 children
my_tree.delete(67)

my_tree.pretty_print

