# frozen_string_literal: true

require_relative 'controller'

# Main game loop
chess_loop = Controller.new

# Displays welcome and instructions
puts "     Welcome to chess!\n\n"
chess_loop.board.draw_game

chess_loop.display_instructions

# Take in player names
puts "\nPlayer 1, what is your name?"
player1 = ''
player1 = gets.chomp until player1.length.positive?

puts "\nPlayer 2, what is your name?"
player2 = ''
player2 = gets.chomp until player2.length.positive?

# Game Loop
until chess_loop.game_over? == true
  chess_loop.board.draw_game

  if chess_loop.active_player == 'Player1'
    puts "#{player1} it's your turn, please input your move."
  else
    puts "#{player2} it's your turn, please input your move."
  end

  move_string = ''
  move_string = gets.chomp until chess_loop.input_move(move_string) == true

  break if chess_loop.game_over? == true

  chess_loop.change_active_player
end

# Draw board, tell player it's their turn
# Ask for user input, loop until it's a valid input
# Update the board
# Check for game over
# Switch active player

# Ask if they want to play again
