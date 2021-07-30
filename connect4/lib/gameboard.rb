# frozen_string_literal: true

# GameBoard where the game is played
class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @game_won = false
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

  def play(marker, column)
    position = 5

    position -= 1 until @board[position][column] == ' ' || position.negative?

    return 'Invalid choice: This column is already full.' if position.negative?

    @board[position][column] = marker
    [position, column]
  end

  def stalemate?
    @board[0].include?(' ') ? false : true
  end

  def horizontal_win?
    @board.each do |row|
      return true if row[0] != ' ' && row[0] == row[1] && row[0] == row[2] && row[0] == row[3]
      return true if row[1] != ' ' && row[1] == row[2] && row[1] == row[3] && row[1] == row[4]
      return true if row[2] != ' ' && row[2] == row[3] && row[2] == row[4] && row[2] == row[5]
      return true if row[3] != ' ' && row[3] == row[4] && row[3] == row[5] && row[3] == row[6]
    end
    false
  end

  def vertical_win?
    0.upto(2) do |y|
      0.upto(6) do |x|
        return true if @board[y][x] != ' ' && @board[y][x] == @board[y + 1][x] && @board[y][x] == @board[y + 2][x] && @board[y][x] == @board[y + 3][x]
      end
    end
    false
  end

  def game_over?
    stalemate? || horizontal_win? || vertical_win?
  end
end
