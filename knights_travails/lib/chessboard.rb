class ChessBoard
  attr_accessor :board

  def initialize
    # 1 Array of 8 length each storing 8 elements
    @board = Hash.new()
    @board[:row_marker] = ["   ", " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 "]
    @board[:a] = Array.new(8) {ChessNode.new}
    @board[:a].prepend(" a ")
    @board[:b] = Array.new(8) {ChessNode.new}
    @board[:b].prepend(" b ")
    @board[:c] = Array.new(8) {ChessNode.new}
    @board[:c].prepend(" c ")
    @board[:d] = Array.new(8) {ChessNode.new}
    @board[:d].prepend(" d ")
    @board[:e] = Array.new(8) {ChessNode.new}
    @board[:e].prepend(" e ")
    @board[:f] = Array.new(8) {ChessNode.new}
    @board[:f].prepend(" f ")
    @board[:g] = Array.new(8) {ChessNode.new}
    @board[:g].prepend(" g ")
    @board[:h] = Array.new(8) {ChessNode.new}
    @board[:h].prepend(" h ")
  end

  def draw
    # Top row needs to be [8] of each array, iterated down until entire board is drawn
    row_count = 8
    until row_count < 0
      @board.each do |key, value|
        if value[row_count].instance_of?(ChessNode)
          print " #{value[row_count].marker} "
        else
          print value[row_count]
        end
      end
      row_count -= 1
      print "\n"
    end
  end
end

class ChessNode
  attr_accessor :piece, :marker

  def initialize(piece="empty")
    reset() if piece == "empty"
  end

  def reset
    @piece = "empty"
    @marker = "O"
  end

  def knight
    @piece = "Knight"
    @marker = "K"
  end
end