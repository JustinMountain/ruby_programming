# frozen_string_literal: true

# GameBoard where the game is played
class ChessBoard
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    init_nodes
  end

  def init_nodes
    @board.each do |row|
      0.upto(7) do |i|
        row[i] = ChessNode.new
      end
    end
  end

  def draw_row(row, index)
    printable = +' '
    printable << (8 - index).to_s
    row.each do |node|
      printable << "  #{node.marker}"
    end
    printable
  end

  def draw_game
    @board.reverse.each_with_index { |row, index| puts draw_row(row, index) }
    puts "    a  b  c  d  e  f  g  h\n\n"
    @board
  end
end

# Chess Node
class ChessNode
  attr_accessor :piece, :marker

  def initialize(piece = 'empty')
    reset_node if piece == 'empty'
  end

  def reset_node
    @piece = 'empty'
    @marker = "\u2654"
  end

  def knight
    @piece = 'Knight'
    @marker = 0
  end
end

board = ChessBoard.new
board.draw_game
