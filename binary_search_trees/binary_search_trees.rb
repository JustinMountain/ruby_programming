class Node
  attr_accessor :value, :left, :right
  def initialize(value=nil, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :my_root, :unsorted, :sorted, :level_order_array, :preorder_array, :inorder_array, :postoder_array
  def initialize(array)
    @unsorted = array
    @sorted = array.sort!.uniq
    @my_root = build_tree(@sorted)
    @level_order_array = []
    @preorder_array = []
    @inorder_array = []
    @postorder_array = []
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
    # Base Case
    return node if node.nil?

    # Recur down the tree
    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)

    # If value == node.value this is the node to be deleted
    else
      # node has 0 or 1 children
      if node.left == nil
        return node.right
      elsif node.right == nil
        return node.left

      # node has 2 children; find the inorder successor
      else
      node.value = min_value(node.right)
      # delete the inorder successor
      node.right = delete(node.value, node.right)
      end
    end
    node
  end

  def min_value(root)
    minv = root.value
    while root.left
      minv = root.left.value
      root = root.left
    end
    minv
  end

  def find(value, node=@my_root)
    # Base Case
    return node if node.value == value || node.nil?
    node.value > value ? find(value, node.left) : find(value, node.right)
  end

  def level_order(queue=[], node=@my_root)
    if @level_order_array.length > 0
      @level_order_array = []
    end

    level_order_recursion(queue, node)
  end

  def level_order_recursion(queue, node)
    @level_order_array.push(node.value)

    # Base Case
    return @level_order_array if queue.length == 0 && node.left == nil && node.right == nil

    # Record current node's children to the queue
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?
    # Recursively work through the queue
    level_order_recursion(queue, queue.shift)    
  end

  def preorder(node=@my_root)
    if @preorder_array.length > 0
      @preorder_array = []
    end
    preorder_recursion(node)
  end

  def preorder_recursion(node)
    # Base Case
    return @preorder_array if node.nil?

    #Record the current node's data to the array, followed by its left and right children
    @preorder_array.push(node.value) 
    preorder_recursion(node.left)
    preorder_recursion(node.right)
  end

  def inorder(node=@my_root)
    if @inorder_array.length > 0
      @inorder_array = []
    end
    inorder_recursion(node)
  end

  def inorder_recursion(node)
    # Base Case
    return @inorder_array if node.nil?

    inorder_recursion(node.left)
    @inorder_array.push(node.value) 
    inorder_recursion(node.right)
  end

  def postorder(node=@my_root)
    if @postorder_array.length > 0
      @postorder_array = []
    end
    postorder_recursion(node)
  end

  def postorder_recursion(node)
    # Base Case
    return @inorder_array if node.nil?

    postorder_recursion(node.left)
    postorder_recursion(node.right)
    @postorder_array.push(node.value) 
  end

  def height(node=@my_root)
    # Height is the distance from the node to the furthest leaf node
    unless node.nil? || node == @my_root
      node = (node.instance_of?(Node) ? find(node.value) : find(node))
    end
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node)
    return height() - height(node)
  end

  def balanced?(node=@my_root)
    # The difference in height of every left/right is not more than 1
    return true if node.nil?
    height(node.left) - height(node.right) <= 1 ? is_balanced = true : is_balanced = false
    return true if is_balanced && balanced?(node.left) && balanced?(node.right)
    false
  end

  def rebalance
    @my_root = build_tree(level_order.sort!.uniq)
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

# Insert Testing
my_tree.insert(9999)
my_tree.insert(999)
my_tree.insert(99)
my_tree.insert(97)
my_tree.insert(98)
my_tree.insert(95)

my_tree.pretty_print

# # Delete Testing
#   # 0 children
# my_tree.delete(5)

#   # 1 child
# my_tree.delete(23)

#   # 2 children
# my_tree.delete(67)

# my_tree.pretty_print

# # Find testing
# puts my_tree.find(324)
# puts my_tree.find(67)

# # Level Order Array Testing
# p my_tree.level_order

# # Preoder Array Testing
# p my_tree.preorder

# # Inorder Array Testing
# p my_tree.inorder

# # Postorder Array Testing
# p my_tree.postorder

# # Height Testing
# p my_tree.height()

# # Depth Testing
# p my_tree.depth(67)

# Balanced? Testing
p my_tree.balanced?

# Rebalance Testing
my_tree.rebalance
my_tree.pretty_print
p my_tree.balanced?
