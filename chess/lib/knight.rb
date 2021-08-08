# frozen_string_literal: true

require_relative '../lib/piece'

# Object to control piece movement
class Knight < Piece
  def all_moves(start)
    # Array of valid moves
    valid_moves = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]
    all_moves = []

    valid_moves.each do |ele|
      ele[0] = ele[0] + start[0]
      ele[1] = ele[1] + start[1]
      all_moves << ele
    end
    all_moves
  end
end
