# frozen_string_literal: true

require_relative 'gameboard', 'pawn', 'rook', 'knight', 'bishop', 'queen', 'king'

# Controller for playing chess
class Controller
  attr_accessor :active_player, :board, :p1pawn1, :p1pawn2, :p1pawn3, :p1pawn4, :p1pawn5, :p1pawn6, :p1pawn7, :p1pawn8, :p1rook1, :p1rook2, :p1knight1, :p1knight2, :p1bishop1, :p1bishop2, :p1queen, :p1king, :p2pawn1, :p2pawn2, :p2pawn3, :p2pawn4, :p2pawn5, :p2pawn6, :p2pawn7, :p2pawn8, :p2rook1, :p2rook2, :p2knight1, :p2knight2, :p2bishop1, :p2bishop2, :p2queen, :p2king

  def initialize
    @active_player = 'Player1'
    @board = GameBoard.new
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

  # Takes in player move input
    # Checks for move validity
    # Updates piece locations
      # piece.location
      # board.reset_location_marker
      # board.update_board
      # board.update_piece_location

  # Checks for win conditions
  # *Prevents king from putting itself in danger

  private

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
  end
end
