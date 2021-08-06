# frozen_string_literal: true

# Chess Node for game pieces to be in
class ChessNode
  attr_accessor :piece, :marker, :owner

  def initialize(piece = 'empty')
    reset_node if piece == 'empty'
  end

  def reset_node
    @piece = 'empty'
    @marker = "\u00B7"
    @owner = ''
  end

  def knight(player)
    @piece = 'Knight'
    @owner = player

    valid_players = %w[Player1 Player2]
    if valid_players.include?(player)
      case player
      when 'Player1'
        @marker = "\u2658"
      when 'Player2'
        @marker = "\u265E"
      end
    else 'Invalid input for updating node'
    end
  end

  def pawn(player)
    @piece = 'Pawn'
    @owner = player

    valid_players = %w[Player1 Player2]
    if valid_players.include?(player)
      case player
      when 'Player1'
        @marker = "\u2659"
      when 'Player2'
        @marker = "\u265F"
      end
    else 'Invalid input for updating node'
    end
  end
end

# Player1 is outlined colour
# Player 2 is solid colour
