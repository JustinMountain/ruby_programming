# frozen_string_literal: true

require_relative 'piece'

# King piece inherits from the Piece object
class King < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = []

    case player
    when 'Player1'
      @marker = "\u265A"
    when 'Player2'
      @marker = "\u2654"
    end
  end
end
