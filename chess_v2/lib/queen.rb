# frozen_string_literal: true

require_relative 'piece'

# Queen piece inherits from the Piece object
class Queen < Piece
  attr_reader :player, :location, :moves_array, :marker

  def initialize(player, location)
    super
    @player = player
    @location = location
    @moves_array = [
      # The Rook's Moveset
      [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
      [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
      [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
      [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
      # The Bipshop's Moveset
      [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
      [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7],
      [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
      [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]
    ]
  end

  def update_marker
    case @player
    when 'Player1'
      @marker = "\u265B"
    when 'Player2'
      @marker = "\u2655"
    end
  end

  def piece_specific_restrictions(board, own_piece_adjusted_moves)
    current_board = board.return_board
    restricted_array = []

    directed_movement = [
      [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]],
      [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]],
      [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]],
      [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]],
      [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]],
      [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]
    ]

    directed_movement.each do |direction|
      direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)
    end

    restricted_array
  end

  private

  def direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)
    direction.each do |position|
      adjusted = adjust_position(position)

      break unless own_piece_adjusted_moves.include?([adjusted[0], adjusted[1]])

      location_marker = current_board[adjusted[0]][adjusted[1]]

      opponent_piece = opponent_occupies?(location_marker)

      restricted_array << [adjusted[0], adjusted[1]] if opponent_piece || location_marker == "\u00B7"

      break if opponent_piece
    end
    restricted_array
  end

  def adjust_position(position)
    adjusted = []

    adjusted[0] = position[0] + @location[0]
    adjusted[1] = position[1] + @location[1]

    adjusted
  end

  def opponent_occupies?(location_marker)
    opponent_piece = false

    case @player
    when 'Player1'
      opponent_piece = true if location_marker.match(/[\u2654-\u2659]/)
    when 'Player2'
      opponent_piece = true if location_marker.match(/[\u265A-\u265F]/)
    end
    opponent_piece
  end
end
