require_relative 'chessboard.rb'
require_relative 'knight.rb'

# Create a recursive method to find paths from one node to another
  # Check if piece is at the end location, return something dumb if both start and finish are equal
  # Otherwise, make an array of all locations on the board

  # Base Case
    # Piece is in the end location or has no more valid moves
  # Check master array crossed with possible moves for new squares to visit, move the piece
  # Check if piece is at the end location
    # Yes, return
    # No, remove current position from master array and recurse

# Find the shortest path from above (depth traversal w/ queue) and return that path

master = [1, 2, 3, 4, 5, 6, 7, 8].product([1, 2, 3, 4, 5, 6, 7, 8])

def knight_moves(start, finish, board=master)
  return "Your knight is already in the end location." if start == finish
end

p master.length