# frozen_string_literal: true

# Object to control knights movement
class Knight
  # Determines the valid moves for a knight at position start_location
  def valid_moves(start, board)
    if start.is_a?(Array) && start.length == 2
      all_moves = all_moves(start)
      possible = possible_moves(all_moves)
      player_correction(start, possible, board)
    else
      'Error'
    end
  end

  # Used in valid_moves
  def all_moves(start)
    # Array of valid moves
    valid_moves = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]
    all_moves = []

    valid_moves.each do |ele|
      ele[0] = ele[0] + start[0]
      ele[1] = ele[1] + start[1]
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

  # Used in valid_moves to limit potential moves to not take own piece
  def player_correction(start, possible, board)
    start_owner = node_owner(start, board)
    corrected = []

    possible.each do |finish|
      finish_owner = node_owner(finish, board)
      corrected << finish if finish_owner != start_owner
    end
    corrected
  end

  # Used in player_correction
  def node_owner(location, board)
    row = location[0]
    column = location[1]
    board.board[row][column].owner
  end

  # Handles updating the gameboard when moving the knight
  def move(start, finish, board)
    if start.is_a?(Integer) || start.length != 2
      'Invalid start location'
    elsif !finish.is_a?(Array) || finish.length != 2
      'Invalid finish location'
    else
      valid_moves = valid_moves(start, board)
      check_move_validity(start, finish, board, valid_moves)
    end
  end

  # Used in #move
  def check_move_validity(start, finish, board, valid_moves)
    if valid_moves.include?(finish)
      update_start(start, board)
      update_finish(finish, board)
    else
      'Invalid move'
    end
  end

  # Used in #move
  def update_start(start, board)
    start_row = start[0]
    start_column = start[1]
    start_node = board.board[start_row][start_column]
    start_node.reset_node
  end

  # Used in #move
  def update_finish(finish, board)
    finish_row = finish[0]
    finish_column = finish[1]
    finish_node = board.board[finish_row][finish_column]
    finish_node.knight
  end
end
