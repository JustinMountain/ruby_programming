class Knight
  def initialize(spawn_loc, board)
    return "Error" unless spawn_loc.is_a?(Array) && spawn_loc.length == 2

    key = position_num_to_key(spawn_loc)
    value = spawn_loc[1]

    this_knight = board.board[key][value]
    this_knight.piece = "Knight"
    this_knight.marker = "K"
    @location = spawn_loc
  end

  def moves?
    # Array of valid moves
    valid_moves = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]
    possible_moves = []

    shifted = valid_moves.each do |ele| 
      ele[0] = ele[0] + @location[0]
      ele[1] = ele[1] + @location[1]
    end

    shifted.each do |ele|
      possible_moves << ele unless (ele[0] > 8 || ele[1] > 8 || ele[0] < 1 || ele[1] < 1)
    end

    return possible_moves 
  end

  def move(start, finish, board)
    return "Error" unless start.is_a?(Array) && start.length == 2
    return "Error" unless finish.is_a?(Array) && finish.length == 2
    return "Invalid Move" unless self.moves?.include?(finish)

    # Change piece and marker at start to nil
    current_loc = board.board[position_num_to_key(start)][start[1]]
    current_loc.piece = "empty"
    current_loc.marker = "O"

    # Change piece and marker at finish to Knight
    finish_loc = board.board[position_num_to_key(finish)][finish[1]]
    finish_loc.piece = "Knight"
    finish_loc.marker = "K"

    return "Knight to #{position_key_to_num(finish)}"
  end
end

def position_num_to_key(spawn_loc)
  key = :a if spawn_loc[0] == 1
  key = :b if spawn_loc[0] == 2
  key = :c if spawn_loc[0] == 3
  key = :d if spawn_loc[0] == 4
  key = :e if spawn_loc[0] == 5
  key = :f if spawn_loc[0] == 6
  key = :g if spawn_loc[0] == 7
  key = :h if spawn_loc[0] == 8
  return key
end

def position_key_to_num(spawn_loc)
  spawn_loc[0] = :a if spawn_loc[0] == 1
  spawn_loc[0] = :b if spawn_loc[0] == 2
  spawn_loc[0] = :c if spawn_loc[0] == 3
  spawn_loc[0] = :d if spawn_loc[0] == 4
  spawn_loc[0] = :e if spawn_loc[0] == 5
  spawn_loc[0] = :f if spawn_loc[0] == 6
  spawn_loc[0] = :g if spawn_loc[0] == 7
  spawn_loc[0] = :h if spawn_loc[0] == 8
  return spawn_loc
end