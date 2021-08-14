# frozen_string_literal: true

# Piece to be used for all Game Pieces
class Piece
  attr_reader :player, :location

  def initialize(player, location)
    @player = player
    @location = location
  end

  def move(board, start, finish)
    board.reset_location_marker(start)
    board.update_board(finish)
  end
end
