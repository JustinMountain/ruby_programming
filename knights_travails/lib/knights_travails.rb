require_relative 'chessboard.rb'
require_relative 'knight.rb'

class Knights_Travails < Knight
  def initialize(start, finish, queue=[])
    @start = start
    @finish = finish
    @board = ChessBoard.new()
    knight = Knight.new(@start, @board)
    queue.push(start)
    start_node = @board.board[position_num_to_key(start)][start[1]]
    # start_node.marker = "S"

    p travails_recursion(queue, knight)

    p @board.draw


    # build a chess board, placing a knight at starting location
      # set the ChessNode @ location start to have a marker of 1 and a piece of an array with start at position 0
    # breadth first search, creating a Queue array of all possible moves for the knight
      # at any of these possible move locations, if the ChessNode has piece == "empty", add them to the Q 
        # also make marker + 1 and piece = current piece + location
    # stop when able to move to finish location
  end

  def travails_recursion(queue, knight, path=[], counter=0)
    if counter == "S"
      counter == "S"
    else
      counter >= 0
      current_node = @board.board[position_num_to_key(queue[0])][queue[0][1]]
      counter = current_node.marker + 1
    end

    possible_moves = knight.moves?(queue.shift)

    possible_moves.each do |move| 
      # ChessNode @ move location
      move_node = @board.board[position_num_to_key(move)][move[1]]

      queue.push(move) if move_node.marker == 0

      update_node = @board.board[position_num_to_key(move)][move[1]]
      update_node.update(counter) if move_node.marker == 0
    end

    # Base Case
    if possible_moves.include?(@finish)
      return  
    end

    travails_recursion(queue, knight, path, counter)
  end
end

start = [1, 1]
finish = [8, 8]

knight = Knights_Travails.new(start, finish)

