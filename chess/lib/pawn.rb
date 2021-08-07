# frozen_string_literal: true

# Object to control pawn movement
class Pawn
  # Determines the valid moves for a knight at position start_location
  def valid_moves(start, board)
    if start.is_a?(Array) && start.length == 2
      all_moves = all_moves(start)
      directed = player_direction(all_moves, start, board)
      player_adjusted = player_correction(directed, start, board)
      possible = possible_moves(player_adjusted)
      player_correction(start, possible, board)
    else
      'Error'
    end
  end

  # Used in valid_moves to determine all potential moves
  def all_moves(start)
    # Array of valid moves
    valid_moves = [[1, 0], [1, 1], [1, -1]]
    all_moves = []

    valid_moves.each do |ele|
      ele[0] = ele[0] + start[0]
      ele[1] = ele[1] + start[1]
      all_moves << ele
    end
    all_moves
  end

  # Determines the direction pawns are allowed to move
  def player_direction(all_moves, start, board)
    row = start[0]
    column = start[1]
    player = board.board[row][column].owner

    all_moves unless player == 'Player2'

    all_moves.each { |pos| pos[0] *= -1 }
    all_moves
  end

  # Used in valid_moves to limit potential moves to be on the board
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

      if finish[1] == start[1]
        corrected << finish if finish_owner == ''
      elsif finish_owner != start_owner && finish_owner != ''
        corrected << finish
      end
    end
    corrected
  end

  # Used in player_correction
  def node_owner(location, board)
    row = location[0]
    column = location[1]
    board.board[row][column].owner
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
      start_owner = node_owner(start, board)
      finish_owner = node_owner(finish, board)

      if finish_owner != start_owner
        update_start(start, board)
        update_finish(finish, board, start_owner)
      end
    else
      'Invalid move'
    end
  end
end
