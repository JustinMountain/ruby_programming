# frozen_string_literal: true

require_relative '../lib/piece'

# Object to control pawn movement
class Pawn < Piece
  # Determines the valid moves for a knight at position start_location
  def valid_moves(start, board)
    if start.is_a?(Array) && start.length == 2
      player = board.board[row][column].owner

      directed_moves = determine_movement(player)
      all_moves = all_moves(start, directed_moves)

      player_corrected = player_correction(all_moves, player)
      possible = possible_moves(player_corrected)
      player_correction(start, possible, board)
    else
      'Error'
    end
  end

  # Used in valid_moves to determine all potential moves
  def all_moves(start, directed_moves)
    # Array of valid moves
    all_moves = []

    directed_moves.each do |ele|
      ele[0] = ele[0] + start[0]
      ele[1] = ele[1] + start[1]
      all_moves << ele
    end
    all_moves
  end

  def determine_movement(player)
    case player
    when 'Player1'
      moves = [[1, -1], [1, 0], [1, 1]]
    when 'Player2'
      moves = [[-1, -1], [-1, 0], [-1, 1]]
    end
    moves
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
end
