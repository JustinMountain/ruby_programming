# frozen_string_literal: true

# GameBoard where the chess game will be played
class GameBoard
  attr_reader :board_array, :p1_pieces, :p2_pieces

  def initialize
    @board_array = Array.new(8) { Array.new(8) }
    @p1_pieces = {}
    @p2_pieces = {}
  end

  def return_board
    @board_array
  end

  def return_p1_pieces
    @p1_pieces
  end

  def return_p2_pieces
    @p2_pieces
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
