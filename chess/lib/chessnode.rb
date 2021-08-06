# frozen_string_literal: true

# Chess Node for game pieces to be in
class ChessNode
  attr_accessor :piece, :marker

  def initialize(piece = 'empty')
    reset_node if piece == 'empty'
  end

  def reset_node
    @piece = 'empty'
    @marker = ' '
  end

  def knight(player)
    @piece = 'Knight'

    valid_players = %w[Player1 Player2]
    if valid_players.include?(player)
      case player
      when 'Player1'
        @marker = "\u2658"
      when 'Player2'
        @marker = "\u265E"
      end
    else 'Invalid input for updating marker'
    end
  end
end
