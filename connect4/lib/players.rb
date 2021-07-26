# frozen_string_literal: true

# GameBoard where the game is played
class Players
  attr_reader :marker1, :marker2, :player1, :player2

  def initialize
    @marker1 = 'O'
    @marker2 = 'X'
    @player1 = 'Player 1'
    @player2 = 'Player 2'
  end

  def update_marker(player, marker)
    valid_players = %w[player1 player2]

    if marker.length == 1 && valid_players.include?(player)
      case player
      when 'player1'
        @marker1 = marker
      when 'player2'
        @marker2 = marker
      end
    else 'Invalid input for updating marker'
    end
  end

  def update_name(player, new_name)
    valid_players = %w[player1 player2]

    if valid_players.include?(player)
      case player
      when 'player1'
        @player1 = new_name
      when 'player2'
        @player2 = new_name
      end
    else 'Invalid input for updating marker'
    end
  end
end
