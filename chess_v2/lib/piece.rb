# frozen_string_literal: true

# Piece to be used for all Game Pieces
class Piece
  attr_reader :player, :moves_array
  attr_accessor :location

  def initialize(player, location)
    @player = player
    @location = location
    @moves_array = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]
  end

  def move(board, start, finish)
    board.reset_location_marker(start)
    board.update_board(finish)
    @location = finish
  end

  # Add the start location to this array
  def moves_from_start(start)
    # start_adjusted = @moves_array
    start_adjusted = Marshal.load(Marshal.dump(@moves_array))

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
      board_adjusted << ele unless ele[0] > 7 || ele[1] > 7 || ele[0].negative? || ele[1].negative?
    end
    board_adjusted
  end

  # Remove any square with player's own pieces in it
  def remove_own_piece_locations(board, player, board_adjusted_moves)
    player_pieces = board.return_player_pieces(player)
    adjusted = []

    board_adjusted_moves.each do |location|
      adjusted << location unless player_pieces.value?(location)
    end
    adjusted
  end

  # Remove any piece-specific restricted positions
  def piece_specific_restrictions(_board, own_piece_adjusted_moves)
    own_piece_adjusted_moves
  end

  def valid_move?(board, player, start, finish)
    p start_adjusted_moves = moves_from_start(start)
    p board_adjusted_moves = remove_invalid_coordinates(start_adjusted_moves)
    p own_piece_adjusted_moves = remove_own_piece_locations(board, player, board_adjusted_moves)
    p piece_restricted = piece_specific_restrictions(board, own_piece_adjusted_moves)
    return true if piece_restricted.include?(finish)

    false
  end
end
