# frozen_string_literal: true

require_relative 'piece'

# Rook piece inherits from the Piece object
class Rook < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = [
      [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
      [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
      [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
      [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
    ]

    case player
    when 'Player1'
      @marker = "\u265C"
    when 'Player2'
      @marker = "\u2656"
    end
  end

  def piece_specific_restrictions(_board, own_piece_adjusted_moves)
    own_piece_adjusted_moves
  end
end

rook = Rook.new('Player1', [1, 1])

start_adjusted_moves = rook.moves_from_start(rook.location)
print start_adjusted_moves
puts ''
board_adjusted_moves = rook.remove_invalid_coordinates(start_adjusted_moves)
print board_adjusted_moves
