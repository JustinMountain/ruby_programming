# frozen_string_literal: true

# Object to control pawn movement
class Pawn
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
    valid_moves = [[1, 0], [1, 1], [1, -1]]
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

  # Handles updating the gameboard when moving the pawn
  def move(start, finish, board)
    if start.is_a?(Integer) || start.length != 2
      'Invalid start location'
    elsif !finish.is_a?(Array) || finish.length != 2
      'Invalid finish location'
    else
      check_validity(start, finish, board)
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
  def update_finish(finish, board, player)
    finish_row = finish[0]
    finish_column = finish[1]
    finish_node = board.board[finish_row][finish_column]
    finish_node.pawn(player)
  end

  # Used in #move
  def check_validity(start, finish, board)
    valid = valid_moves(start)
    if valid.include?(finish)
      start_row = start[0]
      start_column = start[1]
      this_player = board.board[start_row][start_column].owner

      finish_row = finish[0]
      finish_column = finish[1]
      finish_owner = board.board[finish_row][finish_column].owner

      if finish - start == [1] && finish_owner == ''
        update_start(start, board)
        update_finish(finish, board, this_player)
      elsif finish_owner != this_player
        update_start(start, board)
        update_finish(finish, board, this_player)
      end
    else
      'Invalid move'
    end
  end
end
