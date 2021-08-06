# frozen_string_literal: true

require_relative 'chessnode'

# GameBoard where the game is played
class ChessBoard
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
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

  def init_pieces
    init_pawns
    init_knights
  end

  def init_pawns
    @board[6].each { |node| node.pawn('Player1') }
    @board[1].each { |node| node.pawn('Player2') }
  end

  def init_knights
    @board[7][1].knight('Player1')
    @board[7][6].knight('Player1')
    @board[0][1].knight('Player2')
    @board[0][6].knight('Player2')
  end
end

board = ChessBoard.new
board.init_nodes
board.init_pieces
board.draw_game
