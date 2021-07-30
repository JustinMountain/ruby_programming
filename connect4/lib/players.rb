# frozen_string_literal: true

# GameBoard where the game is played
class Players
  attr_accessor :marker1, :marker2, :player1, :player2, :active_player

  def initialize
    @marker1 = 'O'
    @marker2 = 'X'
    @player1 = 'Player 1'
    @player2 = 'Player 2'
    @active_player = nil
  end

  def update_marker(player, marker)
    valid_players = %w[Player1 Player2]

    if marker.length == 1 && valid_players.include?(player)
      case player
      when 'Player1'
        @marker1 = marker
      when 'Player2'
        @marker2 = marker
      end
    else 'Invalid input for updating marker'
    end
  end

  def update_name(player, new_name)
    valid_players = %w[Player1 Player2]

    if valid_players.include?(player)
      case player
      when 'Player1'
        @player1 = new_name
      when 'Player2'
        @player2 = new_name
      end
    else 'Invalid input for updating marker'
    end
  end

  def update_active_player
    @active_player =
      case @active_player
      when @player1 then @player2
      when @player2 then @player1
      else @player1
      end
  end
end
