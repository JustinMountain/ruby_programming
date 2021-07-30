# Game loop for Connect 4
require_relative 'gameboard'
require_relative 'players'

# The Connect 4 Game Loop
class GameLoop
  def initialize
    @players = Players.new
    @board = GameBoard.new
  end

  def play
    instructions
    player_names('Player1')
    player_markers('Player1')
    player_names('Player2')
    player_markers('Player2')
    duplicate_marker
    @board.draw_game
    game_loop
  end

  def player_names(player)
    puts "Please enter #{player}'s name:"
    name = gets.chomp
    @players.update_name(player, name)
  end

  def player_markers(player)
    marker = ''
    puts "\nWhich symbol would you like to use? (I recommend O for Player 1 and X for Player 2):"
    marker = gets.chomp until marker.length == 1 && marker != ' '
    @players.update_marker(player, marker)
  end

  def duplicate_marker
    return unless @players.marker1 == @players.marker2

    marker = ''
    puts 'Please choose a new marker for Player 2:'
    marker = gets.chomp until marker.length == 1 && marker != ' ' && marker != @players.marker1
    @players.marker2 = marker
  end

  def instructions
    puts 'Welcome to Connect 4!'
    puts 'Try to connect 4 of your pieces horizontally, vertically, or diagonally.'
    puts "Who's playing today?\n\n"
  end

  def game_loop
    until @board.game_over?
      @players.update_active_player
      marker = @players.active_marker
      column = ''

      puts "Which column would you like to play in, #{@players.active_player}?"
      column = gets.chomp.to_i until column.is_a?(Integer) && column.positive? && column < 8

      @board.play(marker, column - 1)
      @board.game_over? ? check_end(@board.game_over_condition) : @board.draw_game
    end
  end

  def check_end(condition)
    @board.draw_game
    case condition
    when 'horizontal'
      puts "#{@players.active_player} has won the game with four pieces in a horizontal row!"
    when 'vertical'
      puts "#{@players.active_player} has won the game with four vertical pieces!"
    when 'diagonal'
      puts "#{@players.active_player} has won the game on the diagonal!"
    when 'stalemate'
      puts 'No winner this time... great excuse to play again!'
    end
    play_again
  end

  def play_again
    puts "\nWould you like to play again? (Y/n)"
    valid = %w[Y y N n]
    input = gets.chomp until valid.include?(input)

    return unless valid.include?(input)

    puts "---\n\n\n"
    @players = Players.new
    @board = GameBoard.new
    play
  end
end

# Play the game
new_game = GameLoop.new
new_game.play
