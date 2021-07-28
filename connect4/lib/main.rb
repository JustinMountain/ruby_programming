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

    player_names('Player1')
    player_names('Player2')
  end

  def player_names(player)
    puts "Please enter #{player}'s name:"
    name = gets.chomp
    @players.update_name(player, name)

    marker = ''
    puts "\nWhich symbol would you like to use? (I recommend O for Player 1 and X for Player 2):"
    marker = gets.chomp until marker.length == 1
    @players.update_marker(player, marker)
  end
end
