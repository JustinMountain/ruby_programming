# frozen_string_literal: true

require_relative 'piece'

# Knight piece inherits from the Piece object
class Knight < Piece
  attr_reader :player, :location, :moves_array, :marker

  # Piece uses the knight's movement as its foundation, so no methods are necessary
  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]

    case player
    when 'Player1'
      @marker = "\u265E"
    when 'Player2'
      @marker = "\u2658"
    end
  end
end
