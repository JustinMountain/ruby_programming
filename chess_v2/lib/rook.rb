# frozen_string_literal: true

require_relative 'piece'

# Rook piece inherits from the Piece object
class Rook < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = [
      [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
      [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
      [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
      [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
    ]

    case player
    when 'Player1'
      @marker = "\u265C"
    when 'Player2'
      @marker = "\u2656"
    end
  end

  def piece_specific_restrictions(board, own_piece_adjusted_moves)
    current_board = board.return_board

    adjusted = []
    return_array = []

    directed_movement = [
      [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]],
      [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]]
    ]

    directed_movement.each do |direction|
      direction.each do |position|
        adjusted[0] = position[0] + @location[0]
        adjusted[1] = position[1] + @location[1]

        if own_piece_adjusted_moves.include?([adjusted[0], adjusted[1]])
          location_marker = current_board[adjusted[0]][adjusted[1]]

          case player
          when 'Player1'
            opponent_pieces = location_marker.match(/[\u2654-\u2659]/)
          when 'Player2'
            opponent_pieces = location_marker.match(/[\u265A-\u265F]/)
          end

          if opponent_pieces
            return_array << [adjusted[0], adjusted[1]]
            break
          elsif location_marker == "\u00B7"
            return_array << [adjusted[0], adjusted[1]]
          end
        else
          break
        end
      end
    end

    return_array
  end
end
