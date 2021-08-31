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
finished_playing = false
until finished_playing == true
  until chess_loop.game_over? == true
    chess_loop.board.draw_game

    explain = "it's your turn, please input your move."
    puts '---'

    if chess_loop.active_player == 'Player1'
      puts "#{player1} #{explain}"
    else
      puts "#{player2} #{explain}"
    end

    move_string = ''
    move_string = gets.chomp

    until chess_loop.input_move(move_string) == true
      puts "Invalid move command. Please try again or type 'instructions' to re-read how to play." unless move_string == ''
      move_string = gets.chomp
    end

    game_over = chess_loop.game_over?
    break if game_over == true

    chess_loop.change_active_player
  end

  winner = if @active_player == 'Player1'
             player1
           else
             player2
           end
  puts "\nGood game! #{winner} has won this round."
  puts 'Would you like to play again? (Y/n)'
  again = gets.chomp until again == 'Y' || again == 'n'
  if again == 'Y'
    chess_loop = Controller.new
    puts "     Welcome to chess!\n\n"
  else
    finished_playing = true
  end
end
