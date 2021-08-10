# frozen_string_literal: true

require_relative '../lib/piece'

# Object to control piece movement
class Rook < Piece
  def valid_moves(start, board)
    if start.is_a?(Array) && start.length == 2
      all_moves = all_moves(start, board)

      possible = possible_moves(all_moves)
      player_correction(start, possible, board)
    else
      'Error'
    end
  end

  def all_moves(start, board)
    up = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
    all_moves = one_direction(start, up, board)

    down = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
    all_moves += one_direction(start, down, board)

    left = [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
    all_moves += one_direction(start, left, board)

    right = [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]
    all_moves += one_direction(start, right, board)

    all_moves
  end

  def one_direction(start, direction, board)
    all_moves = []

    direction.each do |ele|
      row = ele[0]
      column = ele[1]
      owner = board.board[row][column]
      break if owner != ''

      ele[0] = ele[0] + start[0]
      ele[1] = ele[1] + start[1]
      all_moves << ele
    end
    all_moves
  end
end
