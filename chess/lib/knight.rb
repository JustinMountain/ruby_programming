# frozen_string_literal: true

# Object to control knights movement
class Knight
  # Determines the valid moves for a knight at position start_location
  def valid_moves(start_location)
    if start_location.is_a?(Array) && start_location.length == 2
      all_moves = all_moves(start_location)
      possible_moves(all_moves)
    else
      'Error'
    end
  end

  # Used in valid_moves
  def all_moves(start_location)
    # Array of valid moves
    valid_moves = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]
    all_moves = []

    valid_moves.each do |ele|
      ele[0] = ele[0] + start_location[0]
      ele[1] = ele[1] + start_location[1]
      all_moves << ele
    end
    all_moves
  end

  # Used in valid_moves
  def possible_moves(all_moves)
    possible_moves = []

    all_moves.each do |ele|
      possible_moves << ele unless ele[0] > 8 || ele[1] > 8 || ele[0] < 1 || ele[1] < 1
    end
    possible_moves
  end

  def move(start, finish, board)
    'Error' unless start.is_a?(Array) && start.length == 2
    'Error' unless finish.is_a?(Array) && finish.length == 2
    'Invalid Move' unless self.moves?.include?(finish)

    current_loc = board.board[position_num_to_key(start)][start[1]]
    current_loc.reset

    finish_loc = board.board[position_num_to_key(finish)][finish[1]]
    finish_loc.knight

    # Commented out to be used in Chess later
    # Change piece and marker at start to nil
    current_loc = board.board[position_num_to_key(start)][start[1]]
    current_loc.reset

    # Change piece and marker at finish to Knight
    finish_loc = board.board[position_num_to_key(finish)][finish[1]]
    finish_loc.knight

    "Knight to #{position_key_to_num(finish)}"
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
  key
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
  spawn_loc
end
