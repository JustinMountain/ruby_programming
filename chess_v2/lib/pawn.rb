# frozen_string_literal: true

require_relative 'piece'

# Pawn piece inherits from the Piece object
class Pawn < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = []

    case player
    when 'Player1'
      @marker = "\u265F"
    when 'Player2'
      @marker = "\u2659"
    end
  end
end
