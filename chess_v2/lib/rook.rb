# frozen_string_literal: true

require_relative 'piece'

# Rook piece inherits from the Piece object
class Rook < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = []

    case player
    when 'Player1'
      @marker = "\u265C"
    when 'Player2'
      @marker = "\u2656"
    end
  end
end
