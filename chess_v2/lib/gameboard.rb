# frozen_string_literal: true

require_relative 'gameboard', 'pawn'

# GameBoard where the chess game will be played
class GameBoard
  attr_reader :board_array, :p1_pieces, :p2_pieces

  def initialize
    @board_array = Array.new(8) { Array.new(8) }
    @p1_pieces = init_p1_pieces_hash
    @p2_pieces = init_p2_pieces_hash
  end

  def init_p1_pieces_hash
    {
      'pawn1' => [1, 0], 'pawn2' => [1, 1], 'pawn3' => [1, 2], 'pawn4' => [1, 3],
      'pawn5' => [1, 4], 'pawn6' => [1, 5], 'pawn7' => [1, 6], 'pawn8' => [1, 7],
      'rook1' => [0, 0], 'rook2' => [0, 7],
      'knight1' => [0, 1], 'knight2' => [0, 6],
      'bishop1' => [0, 2], 'bishop2' => [0, 5],
      'queen' => [0, 4],
      'king' => [0, 3]
    }
  end

  def init_p2_pieces_hash
    {
      'pawn1' => [6, 0], 'pawn2' => [6, 1], 'pawn3' => [6, 2], 'pawn4' => [6, 3],
      'pawn5' => [6, 4], 'pawn6' => [6, 5], 'pawn7' => [6, 6], 'pawn8' => [6, 7],
      'rook1' => [7, 0], 'rook2' => [7, 7],
      'knight1' => [7, 1], 'knight2' => [7, 6],
      'bishop1' => [7, 2], 'bishop2' => [7, 5],
      'queen' => [7, 4],
      'king' => [7, 3]
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
    piece_sym = piece.to_sym

    if pieces_hash.key?(piece_sym)
      pieces_hash.delete(piece_sym)
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
    piece_sym = piece.to_sym

    if pieces_hash.key?(piece_sym)
      pieces_hash[piece_sym] = new_location
    else
      "Piece doesn't exist."
    end
    pieces_hash
  end
end
