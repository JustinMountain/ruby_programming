# Game loop for Connect 4
require_relative 'gameboard'
require_relative 'players'

# Get Player 1's name and marker
# Get Player 2's name and marker

# Start game with player 1
# Loop over placing piece until the game has been completed

# The Connect 4 Game Loop
class GameLoop
  attr_reader :players

  def initialize
    @players = Players.new
    @board = GameBoard.new
  end

  def player_names(player)
    puts "Please enter #{player}'s name:"
    name = gets.chomp
    @players.update_name(player, name)
  end

  def player_markers(player)
    p1_marker = @players.marker1
    p2_marker = @players.marker2

    marker = ''
    puts "\nWhich symbol would you like to use? (I recommend O for Player 1 and X for Player 2):"
    marker = gets.chomp until marker.length == 1 && marker != p1_marker && marker != p2_marker && marker != ' '
    @players.update_marker(player, marker)
  end
end

# Implement the game loop
# new_game = GameLoop.new
# new_game.player_names('Player1')
# new_game.player_markers('Player1')
# new_game.player_names('Player2')
# new_game.player_markers('Player2')

# puts new_game.players.marker1
# puts new_game.players.marker2
# puts new_game.players.player1
# puts new_game.players.player2
