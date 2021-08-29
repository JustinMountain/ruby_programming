# frozen_string_literal: true

require_relative 'gameboard'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

# Controller for playing chess
class Controller
  attr_accessor :active_player, :board, :p1pawn1, :p1pawn2, :p1pawn3, :p1pawn4, :p1pawn5, :p1pawn6, :p1pawn7, :p1pawn8, :p1rook1, :p1rook2, :p1knight1, :p1knight2, :p1bishop1, :p1bishop2, :p1queen, :p1king, :p2pawn1, :p2pawn2, :p2pawn3, :p2pawn4, :p2pawn5, :p2pawn6, :p2pawn7, :p2pawn8, :p2rook1, :p2rook2, :p2knight1, :p2knight2, :p2bishop1, :p2bishop2, :p2queen, :p2king

  def initialize
    @active_player = 'Player1'
    @board = GameBoard.new
    @board.init_board

    init_p1_pieces
    init_p2_pieces
  end

  # Updates the active player
  def change_active_player
    @active_player = if @active_player == 'Player1'
                       'Player2'
                     else
                       'Player1'
                     end
  end

  def input_move(move_string)
    # Takes in player move input
    return 'Invalid movement input' unless check_move_input_format(move_string) == "It's Good!"

    # Checks for a piece at the start location
    start_location = return_location_coords(move_string[1], move_string[2])
    piece_name = player_piece_at_location(start_location)
    return 'No player piece at location' unless piece_name

    # Checks for move validity

    piece = return_piece(piece_name)
    finish_location = return_location_coords(move_string[4], move_string[5])

    piece.valid_move?(@board, @active_player, start_location, finish_location)

    # Updates piece locations
      # piece.location
      # board.reset_location_marker
      # board.update_board
      # board.update_piece_location
  end

  # Checks for win conditions
  # *Prevents king from putting itself in danger

  private

  def return_piece(piece_name)
    if piece_name.include?('p1')
      return_p1_piece_object(piece_name)
    elsif piece_name.include?('p2')
      return_p2_piece_object(piece_name)
    end
  end

  def return_p1_piece_object(piece_name)
    case piece_name
    when 'p1pawn1'
      @p1pawn1
    when 'p1pawn2'
      @p1pawn2
    when 'p1pawn3'
      @p1pawn3
    when 'p1pawn4'
      @p1pawn4
    when 'p1pawn5'
      @p1pawn5
    when 'p1pawn6'
      @p1pawn6
    when 'p1pawn7'
      @p1pawn7
    when 'p1pawn8'
      @p1pawn8
    when 'p1rook1'
      @p1rook1
    when 'p1rook2'
      @p1rook2
    when 'p1knight1'
      @p1knight1
    when 'p1knight2'
      @p1knight2
    when 'p1bishop1'
      @p1bishop1
    when 'p1bishop2'
      @p1bishop2
    when 'p1queen'
      @p1queen
    when 'p1king'
      @p1king
    end
  end

  def return_p2_piece_object(piece_name)
    case piece_name
    when 'p2pawn1'
      @p2pawn1
    when 'p2pawn2'
      @p2pawn2
    when 'p2pawn3'
      @p2pawn3
    when 'p2pawn4'
      @p2pawn4
    when 'p2pawn5'
      @p2pawn5
    when 'p2pawn6'
      @p2pawn6
    when 'p2pawn7'
      @p2pawn7
    when 'p2pawn8'
      @p2pawn8
    when 'p2rook1'
      @p2rook1
    when 'p2rook2'
      @p2rook2
    when 'p2knight1'
      @p2knight1
    when 'p2knight2'
      @p2knight2
    when 'p2bishop1'
      @p2bishop1
    when 'p2bishop2'
      @p2bishop2
    when 'p2queen'
      @p2queen
    when 'p2king'
      @p2king
    end
  end

  def player_piece_at_location(start_location)
    case @active_player
    when 'Player1'
      piece = @board.p1_pieces.key(start_location)
    when 'Player2'
      piece = @board.p2_pieces.key(start_location)
    end
    piece
  end

  def return_location_coords(letter, number)
    location = []
    location[0] = number.to_i - 1
    location[1] = letter_position_to_row(letter)
    location
  end

  def letter_position_to_row(letter)
    position_to_row = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7 }
    position_to_row[letter]
  end

  def check_move_input_format(move_string)
    return 'Invalid move string format.' unless move_string.is_a?(String) && move_string.length == 6
    return 'Invalid piece notation.' unless check_piece(move_string[0])
    return 'Invalid start location.' unless check_grid_coord(move_string[1], move_string[2])
    return 'Invalid movement marker.' unless check_movement_marker(move_string[3])
    return 'Invalid finish location.' unless check_grid_coord(move_string[4], move_string[5])

    "It's Good!"
  end

  def check_piece(piece)
    valid_pieces = %w[B N R K Q P]
    return false unless valid_pieces.include?(piece)

    true
  end

  def check_grid_coord(letter, number)
    return false unless letter.match(/[a-h]/) && number.match(/[0-7]/)

    true
  end

  def check_movement_marker(move)
    valid_markers = %w[- x]
    return false unless valid_markers.include?(move)

    true
  end

  # Initiates a new pieces
  def init_p1_pieces
    init_p1_pawns
    @p1rook1 = Rook.new('Player1', [0, 0])
    @p1rook2 = Rook.new('Player1', [0, 7])
    @p1knight1 = Knight.new('Player1', [0, 1])
    @p1knight2 = Knight.new('Player1', [0, 6])
    @p1bishop1 = Bishop.new('Player1', [0, 2])
    @p1bishop2 = Bishop.new('Player1', [0, 5])
    @p1queen = Queen.new('Player1', [0, 4])
    @p1king = King.new('Player1', [0, 3])
    push_p1_pieces_to_board
  end

  def push_p1_pieces_to_board
    @board.update_board([0, 0], @p1rook1)
    @board.update_board([0, 7], @p1rook2)
    @board.update_board([0, 1], @p1knight1)
    @board.update_board([0, 6], @p1knight2)
    @board.update_board([0, 2], @p1bishop1)
    @board.update_board([0, 5], @p1bishop2)
    @board.update_board([0, 4], @p1queen)
    @board.update_board([0, 3], @p1king)
  end

  def init_p1_pawns
    @p1pawn1 = Pawn.new('Player1', [1, 0])
    @p1pawn2 = Pawn.new('Player1', [1, 1])
    @p1pawn3 = Pawn.new('Player1', [1, 2])
    @p1pawn4 = Pawn.new('Player1', [1, 3])
    @p1pawn5 = Pawn.new('Player1', [1, 4])
    @p1pawn6 = Pawn.new('Player1', [1, 5])
    @p1pawn7 = Pawn.new('Player1', [1, 6])
    @p1pawn8 = Pawn.new('Player1', [1, 7])
    push_p1_pawns_to_board
  end

  def push_p1_pawns_to_board
    @board.update_board([1, 0], @p1pawn1)
    @board.update_board([1, 1], @p1pawn2)
    @board.update_board([1, 2], @p1pawn3)
    @board.update_board([1, 3], @p1pawn4)
    @board.update_board([1, 4], @p1pawn5)
    @board.update_board([1, 5], @p1pawn6)
    @board.update_board([1, 6], @p1pawn7)
    @board.update_board([1, 7], @p1pawn8)
  end

  def init_p2_pieces
    init_p2_pawns
    @p2rook1 = Rook.new('Player2', [7, 0])
    @p2rook2 = Rook.new('Player2', [7, 7])
    @p2knight1 = Knight.new('Player2', [7, 1])
    @p2knight2 = Knight.new('Player2', [7, 6])
    @p2bishop1 = Bishop.new('Player2', [7, 2])
    @p2bishop2 = Bishop.new('Player2', [7, 5])
    @p2queen = Queen.new('Player2', [7, 4])
    @p2king = King.new('Player2', [7, 3])
    push_p2_pieces_to_board
  end

  def push_p2_pieces_to_board
    @board.update_board([7, 0], @p2rook1)
    @board.update_board([7, 7], @p2rook2)
    @board.update_board([7, 1], @p2knight1)
    @board.update_board([7, 6], @p2knight2)
    @board.update_board([7, 2], @p2bishop1)
    @board.update_board([7, 5], @p2bishop2)
    @board.update_board([7, 4], @p2queen)
    @board.update_board([7, 3], @p2king)
  end

  def init_p2_pawns
    @p2pawn1 = Pawn.new('Player2', [6, 0])
    @p2pawn2 = Pawn.new('Player2', [6, 1])
    @p2pawn3 = Pawn.new('Player2', [6, 2])
    @p2pawn4 = Pawn.new('Player2', [6, 3])
    @p2pawn5 = Pawn.new('Player2', [6, 4])
    @p2pawn6 = Pawn.new('Player2', [6, 5])
    @p2pawn7 = Pawn.new('Player2', [6, 6])
    @p2pawn8 = Pawn.new('Player2', [6, 7])
    push_p2_pawns_to_board
  end

  def push_p2_pawns_to_board
    @board.update_board([6, 0], @p2pawn1)
    @board.update_board([6, 1], @p2pawn2)
    @board.update_board([6, 2], @p2pawn3)
    @board.update_board([6, 3], @p2pawn4)
    @board.update_board([6, 4], @p2pawn5)
    @board.update_board([6, 5], @p2pawn6)
    @board.update_board([6, 6], @p2pawn7)
    @board.update_board([6, 7], @p2pawn8)
  end
end

controller = Controller.new
controller.board.draw_game
p controller.input_move('Nb2-b4')
