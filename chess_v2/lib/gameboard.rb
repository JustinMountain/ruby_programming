# frozen_string_literal: true

require_relative 'gameboard'

# GameBoard where the chess game will be played
class GameBoard
  attr_reader :board_array
  attr_accessor :p1_pieces, :p2_pieces

  def initialize
    @board_array = Array.new(8) { Array.new(8) }

    @p1_pieces = init_p1_pieces_hash
    @p2_pieces = init_p2_pieces_hash
  end

  def init_p1_pieces_hash
    {
      'p1pawn1' => [1, 0], 'p1pawn2' => [1, 1], 'p1pawn3' => [1, 2], 'p1pawn4' => [1, 3],
      'p1pawn5' => [1, 4], 'p1pawn6' => [1, 5], 'p1pawn7' => [1, 6], 'p1pawn8' => [1, 7],
      'p1rook1' => [0, 0], 'p1rook2' => [0, 7],
      'p1knight1' => [0, 1], 'p1knight2' => [0, 6],
      'p1bishop1' => [0, 2], 'p1bishop2' => [0, 5],
      'p1queen' => [0, 4],
      'p1king' => [0, 3]
    }
  end

  def init_p2_pieces_hash
    {
      'p2pawn1' => [6, 0], 'p2pawn2' => [6, 1], 'p2pawn3' => [6, 2], 'p2pawn4' => [6, 3],
      'p2pawn5' => [6, 4], 'p2pawn6' => [6, 5], 'p2pawn7' => [6, 6], 'p2pawn8' => [6, 7],
      'p2rook1' => [7, 0], 'p2rook2' => [7, 7],
      'p2knight1' => [7, 1], 'p2knight2' => [7, 6],
      'p2bishop1' => [7, 2], 'p2bishop2' => [7, 5],
      'p2queen' => [7, 4],
      'p2king' => [7, 3]
    }
  end

  def return_board
    @board_array
  end

  def return_player_pieces(player)
    return @p1_pieces if player == 'Player1'
    return @p2_pieces if player == 'Player2'
  end

  def draw_game
    @board_array.reverse.each_with_index { |row, index| puts draw_row(row, index) }
    puts "    a  b  c  d  e  f  g  h\n\n"
    @board_array
  end

  def draw_row(row, index)
    printable = +' '
    printable << (8 - index).to_s
    row.each do |location|
      printable << "  #{location}"
    end
    printable
  end

  def remove_piece(pieces_hash, piece)
    if pieces_hash.key?(piece)
      pieces_hash.delete(piece)
    else
      "Piece doesn't exist."
    end
  end

  def reset_location_marker(location)
    return 'Location must be an array of length 2' unless location.is_a?(Array) && location.length == 2

    row = location[0]
    column = location[1]

    return 'Invalid coordinates' unless row >= 0 && row <= 7 && column >= 0 && column <= 7

    @board_array[row][column] = "\u00B7"
  end

  def update_board(location, piece_object)
    return 'Location must be an array of length 2' unless location.is_a?(Array) && location.length == 2

    row = location[0]
    column = location[1]

    return 'Invalid coordinates' unless row >= 0 && row <= 7 && column >= 0 && column <= 7

    @board_array[row][column] = piece_object.marker
  end

  def update_piece_location(pieces_hash, piece, new_location)
    if pieces_hash.key?(piece)
      pieces_hash[piece] = new_location
    else
      "Piece doesn't exist."
    end
    pieces_hash
  end

  def init_board
    (0..7).each do |row|
      (0..7).each do |column|
        location = [row, column]
        reset_location_marker(location)
      end
    end
  end
end
