class GameSquare
  def initialize
    puts "I'm a game square"
  end
end

class GameBoard
  def initialize
    puts "I need to draw the Game Board with this method"
  end
end

top_left = GameSquare.new()
board = GameBoard.new()

# GameSquare class to initialize with a number from 1 - 9
# Needs to be able to be updated one time to X or one
# GameBoard needs to be able to draw the board with GameSquares populating the appropriate spaces
# class NewGame that resets all GameSquares
# control game state between two players
# check for a winner