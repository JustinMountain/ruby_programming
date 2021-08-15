# frozen_string_literal: true

# Piece to be used for all Game Pieces
class Piece
  attr_reader :player, :location, :moves_array

  def initialize(player, location)
    @player = player
    @location = location
    @moves_array = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]
  end

  def move(board, start, finish)
    board.reset_location_marker(start)
    board.update_board(finish)
  end

  # Add the start location to this array
  def moves_from_start(start)
    start_adjusted = @moves_array

    start_adjusted.each do |ele|
      ele[0] = ele[0] + start[0]
      ele[1] = ele[1] + start[1]
    end
    start_adjusted
  end

  # Remove any coordinates that aren't on the board (position greater than 8 or less than 1)
  def remove_invalid_coordinates(start_adjusted_moves)
    board_adjusted = []

    start_adjusted_moves.each do |ele|
      board_adjusted << ele unless ele[0] > 7 || ele[1] > 7 || ele[0] < 0 || ele[1] < 0
    end
    board_adjusted
  end

  # Remove any square with player's own pieces in it
  def remove_own_piece_locations(board, board_adjusted_moves)
  end

  # Remove any piece-specific restricted positions
  def piece_specific_restrictions(own_piece_adjusted_moves)
  end

  # def valid_move?(start, finish)
  #   start_adjusted_moves = moves_from_start(start)
  #   board_adjusted_moves = remove_invalid_coordinates(start_adjusted_moves)
  #   own_piece_adjusted_moves = remove_own_piece_locations(board_adjusted_moves)
  #   piece_rectricted = piece_specific_restrictions(own_piece_adjusted_moves)
  #   true if piece_rectricted.include(finish)
  #   false
  # end
end
