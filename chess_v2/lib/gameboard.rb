# frozen_string_literal: true

class GameBoard
  attr_reader :board_array, :p1_pieces, :p2_pieces

  def initialize
    @board_array = Array.new(8) { Array.new(8) }
    @p1_pieces = {}
    @p2_pieces = {}
  end

  def draw_game
    @board_array.reverse.each_with_index { |row, index| puts draw_row(row, index) }
    puts "    a  b  c  d  e  f  g  h\n\n"
    @board_array
  end

  def draw_row(row, index)
    printable = +' '
    printable << (8 - index).to_s
    row.each do |location|
      printable << "  #{location}"
    end
    printable
  end
end
