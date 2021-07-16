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
    start_node.path = start
    @path = [Array.new(7) { Array.new }]
    @path[0] = start_node.path

    p travails_recursion(queue, knight)

    p @counter
  end

  def travails_recursion(queue, knight, path=[], counter=0)
    # Increment counter by resetting to current value + 1
    current_node = @board.board[position_num_to_key(queue[0])][queue[0][1]]
    @counter = current_node.marker + 1
    @path = current_node.path.dup

    # Add to Queue and update move counter
    possible_moves = knight.moves?(queue.shift)
    possible_moves.each do |move| 
      move_node = @board.board[position_num_to_key(move)][move[1]]

      queue.push(move) if move_node.marker == 0
      @path.push(move)

      update_node = @board.board[position_num_to_key(move)][move[1]]
      update_node.update(@counter, @path) if move_node.marker == 0
      @path.pop
    end

    # Base Case
    if possible_moves.include?(@finish)
      @path.push(@finish)
      return @path
    end

    travails_recursion(queue, knight, @path, @counter)
  end
end

start = [1, 1]
finish = [8, 8]

knight = Knights_Travails.new(start, finish)

