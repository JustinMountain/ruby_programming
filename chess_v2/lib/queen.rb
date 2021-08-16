# frozen_string_literal: true

require_relative 'piece'

# Queen piece inherits from the Piece object
class Queen < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = []

    case player
    when 'Player1'
      @marker = "\u265B"
    when 'Player2'
      @marker = "\u2655"
    end
  end
end
