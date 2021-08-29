# frozen_string_literal: true

require_relative 'piece'

# Pawn piece inherits from the Piece object
class Pawn < Piece
  attr_reader :player, :moves_array, :marker
  attr_accessor :location

  def initialize(player, location)
    super
    @player = player
    @location = location
    @marker = update_marker

    case @player
    when 'Player1'
      @moves_array = [[2, 0], [1, 0], [1, -1], [1, 1]]
    when 'Player2'
      @moves_array = [[-2, 0], [-1, 0], [-1, -1], [-1, 1]]
    end
  end

  def update_marker
    case @player
    when 'Player1'
      @marker = "\u265F"
    when 'Player2'
      @marker = "\u2659"
    end
  end

  def piece_specific_restrictions(board, own_piece_adjusted_moves)
    current_board = board.return_board
    restricted_array = []

    case @player
    when 'Player1'
      directed_movement = if @location[0] == 1
                            [
                              [[1, 0], [2, 0]],
                              [[1, -1]],
                              [[1, 1]]
                            ]
                          else
                            [
                              [[1, 0]],
                              [[1, -1]],
                              [[1, 1]]
                            ]
                          end
    when 'Player2'
      directed_movement = if @location[0] == 6
                            [
                              [[-1, 0], [-2, 0]],
                              [[-1, -1]],
                              [[-1, 1]]
                            ]
                          else
                            [
                              [[-1, 0]],
                              [[-1, -1]],
                              [[-1, 1]]
                            ]
                          end
    end

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

      restricted_array << [adjusted[0], adjusted[1]] if opponent_piece && position[1] != 0
      restricted_array << [adjusted[0], adjusted[1]] if !opponent_piece && position[1].zero?

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
