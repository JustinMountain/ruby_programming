require_relative 'chessboard.rb'
require_relative 'knight.rb'

class Knights_Travails < Knight
  def initialize(start, finish, queue=[])
    # Initialize variables for use
    @start = start
    @finish = finish
    @board = ChessBoard.new()

    queue.push(start)
    knight = Knight.new(@start, @board)
    @path = []

    # Setup path for starting position
    start_node = @board.board[position_num_to_key(start)][start[1]]
    start_node.path = Array.new(1) { Array.new }
    start_node.path.push(start)

    # Run the recursion
    travails_recursion(queue, knight)
    print_results(@path, @counter)
  end

  def travails_recursion(queue, knight, path=[], counter=0)
    # Increment counter by resetting to current value + 1
    current_node = @board.board[position_num_to_key(queue[0])][queue[0][1]]
    @counter = current_node.marker + 1
    @path = current_node.path.dup

    # Add to Queue and update move counter and path-so-far
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

  def print_results(path, distance)
    puts "The knight can make it in #{distance} moves:"
    path.each do |position|
      p position unless position.empty?
    end
  end
end

start = [4, 4]
finish = [2, 4]

knight_moves = Knights_Travails.new(start, finish)