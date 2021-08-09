# frozen_string_literal: true

require_relative '../lib/piece'

# Object to control piece movement
class Rook < Piece
  def valid_moves(start, board)
    if start.is_a?(Array) && start.length == 2
      all_moves = all_moves(start)

      limited = limit_moves(all_moves, board)

      possible = possible_moves(limited)
      player_correction(start, possible, board)
    else
      'Error'
    end
  end

  def all_moves(start)
    # Array of valid moves
    valid_moves = [
      [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
      [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
      [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
      [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
    ]
    all_moves = []

    valid_moves.each do |ele|
      ele[0] = ele[0] + start[0]
      ele[1] = ele[1] + start[1]
      all_moves << ele
    end
    all_moves
  end

  # Limits potential moves if piece is blocking movement
  def limit_moves(all_moves, board)
    limited = []

    all_moves.each do |pos|
      row = pos[0]
      column = pos[1]
      owner = board.board[row][column]
      limited << pos if owner == ''
      break if owner != ''
    end
    limited
  end
end
