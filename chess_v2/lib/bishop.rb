# frozen_string_literal: true

require_relative 'piece'

# Bishop piece inherits from the Piece object
class Bishop < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = []

    case player
    when 'Player1'
      @marker = "\u265D"
    when 'Player2'
      @marker = "\u2657"
    end
  end
end
