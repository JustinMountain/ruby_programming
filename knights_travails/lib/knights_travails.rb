require_relative 'chessboard.rb'
require_relative 'knight.rb'

test_board = ChessBoard.new()

test_knight = Knight.new([4, 4], test_board)

test_board.draw

p test_knight.moves?
p test_knight.move([4, 4], [6, 3], test_board)

test_board.draw
