# frozen_string_literal: true

# GameBoard where the game is played
class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
  end

  def draw_row(row)
    printable = +' | '
    row.each { |cell| printable << "#{cell} | " }
    printable
  end

  def draw_game
    @board.each { |row| puts draw_row(row) }
    puts ' ----------------------------- '
    puts "   1   2   3   4   5   6   7\n\n"
    @board
  end
end
