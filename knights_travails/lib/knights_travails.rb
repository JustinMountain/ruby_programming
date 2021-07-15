require_relative 'chessboard.rb'
require_relative 'knight.rb'

class Knights_Travails < Knight
  def initialize(start, finish, board=@master)

    # Check if piece is at the end location, return something dumb if both start and finish are equal
    if start == finish
      puts "Start and finish are equal; the knight doesn't need to move to be in the finish location." 
      return
    end

    # Otherwise, make an array of all locations on the board
    @master = [1, 2, 3, 4, 5, 6, 7, 8].product([1, 2, 3, 4, 5, 6, 7, 8]) 
    @path = []

    tree = build_move_tree(start, finish)

    p tree
    p @path
  end

  def build_move_tree(start, finish, remaining=@master)

    remaining.delete(start)
    moves = self.moves?(start)
    available_moves = []

    moves.each do |move|
      available_moves.append(move) if remaining.include?(move)
    end

    # p available_moves

    # Base Case
      # Piece is in the end location or has no more valid moves
    if start == finish
      @path.prepend(start)
      return
    elsif available_moves.include?(finish)
      @path.append(finish)
      @path.prepend(start)
    elsif available_moves.length == 0
      return nil
    end
  
    return nil if available_moves.length == 0

    node = Move_Node.new(start)

    # Check master array crossed with possible moves for new squares to visit, move the piece

    # Check if piece can move to end location
    i = 0
    while i <= 8
      if available_moves[i].is_a?(Array)
        node.possible_moves[i] = build_move_tree(available_moves[i], finish, remaining)
      end
      if available_moves[i + 1] == nil
        i = 8
      else
        i += 1
      end
    end
      # Yes, return
      # Recurse
    node
    # Find the shortest path from above (depth traversal w/ queue) and return that path
  end
end

class Move_Node
  attr_accessor :possible_moves
  def initialize(location)
    @location = location
    @possible_moves = Array.new(8)
  end
end


# def Knight_moves(start, finish, board=master)
#   return "Your knight is already in the end location." if start == finish
# end

start = [1, 1]
finish = [3, 5]

knight = Knights_Travails.new(start, finish)

