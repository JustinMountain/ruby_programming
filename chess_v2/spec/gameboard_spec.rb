# frozen_string_literal: true

require_relative '../lib/gameboard.rb'

RSpec.describe GameBoard do
  describe '#initialize' do
    let(:gameboard) { described_class.new }

    it 'should initialize with an array of length 8 (representing 8 rows)' do
      expect(gameboard.board_array.length).to eq(8)
    end

    it 'should create an array of length 8 at each index (representing 8 columns)' do
      gameboard.board_array.each do |row|
        expect(row.length).to eq(8)
      end
    end

    it 'should return nil at each location[row][column]' do
      gameboard.board_array.each do |row|
        row.each do |col|
          expect(col).to be_nil
        end
      end
    end

    it 'should initialize with a hash for Player 1s pieces' do
      expect(gameboard.p1_pieces).to be_a(Hash)
    end

    it 'should initialize with a hash for Player 2s pieces' do
      expect(gameboard.p2_pieces).to be_a(Hash)
    end
  end

  describe '#draw_game' do
    let(:gameboard) { described_class.new }

    it 'should output 9 lines to the console (8 rows and column markers)' do
      expect($stdout).to receive(:puts).exactly(9).times
      gameboard.draw_game
    end

    it 'should return the current (initialized) gameboard' do
      returned_board = gameboard.draw_game
      expect(returned_board.length).to eq(8)

      gameboard.board_array.each do |row|
        expect(row.length).to eq(8)
        row.each do |col|
          expect(col).to be_nil
        end
      end
    end
  end

  describe '#draw_row' do
    let(:gameboard) { described_class.new }

    it 'should return the row with its adjusted index number' do
      row = ['', '', '', '', '', '', '', '']
      index = 2
      returned_row = gameboard.draw_row(row, index)
      expect(returned_row).to start_with('')
      expect(returned_row).to include((8 - index).to_s)
    end
  end

  describe '#remove_piece' do
    let(:gameboard) { described_class.new }

    context 'removing a piece from player 1' do
      it 'should remove a piece from the appropriate players hash' do
        p1_pieces_mock = { 'pawn1': [2, 1], 'pawn2': [2, 2] }
        piece = 'pawn1'

        gameboard.remove_piece(p1_pieces_mock, piece)
        expect(p1_pieces_mock).not_to have_key(piece)
      end

      it 'should return a string error if the piece is not in the hash' do
        p1_pieces_mock = { 'pawn1': [2, 1], 'pawn2': [2, 2] }
        piece = 'pawn3'
        string_error = "Piece doesn't exist."

        return_string = gameboard.remove_piece(p1_pieces_mock, piece)
        expect(return_string).to eq(string_error)
      end
    end
  end

  describe '#reset_location_marker' do
    let(:gameboard) { described_class.new }

    it 'returns a string error if not given an array' do
      string_error = 'Location must be an array of length 2'
      location = 1

      location_contents = gameboard.reset_location_marker(location)
      expect(location_contents).to eq(string_error)
    end

    it 'returns a string error if not given an array of length 2' do
      string_error = 'Location must be an array of length 2'
      location = [1]

      location_contents = gameboard.reset_location_marker(location)
      expect(location_contents).to eq(string_error)
    end

    it 'returns a string error if coordinates are not on the gameboard' do
      string_error = 'Invalid coordinates'
      location = [8, 8]

      location_contents = gameboard.reset_location_marker(location)
      expect(location_contents).to eq(string_error)
    end

    it 'returns a string error if coordinates are negative' do
      string_error = 'Invalid coordinates'
      location = [-1, -1]

      location_contents = gameboard.reset_location_marker(location)
      expect(location_contents).to eq(string_error)
    end

    it 'updates the board from initialized state' do
      location = [2, 2]
      location_contents = gameboard.reset_location_marker(location)

      expect(location_contents).to eq("\u00B7")
    end

    it 'can reset the position when already displaying a piece' do
      row = rand(0..7)
      column = rand(0..7)
      gameboard.board_array[row][column] = "\u265C"
      expect(gameboard.board_array[row][column]).to eq("\u265C")

      location = [row, column]
      location_contents = gameboard.reset_location_marker(location)

      expect(location_contents).to eq("\u00B7")
    end
  end

  describe '#update_board' do
    let(:gameboard) { described_class.new }

    before do
      @mock_piece = double('Piece', marker: "\u265C") # Solid Rook
    end

    it 'returns a string error if not given an array' do
      string_error = 'Location must be an array of length 2'
      location = 1

      location_contents = gameboard.update_board(location, @mock_piece)
      expect(location_contents).to eq(string_error)
    end

    it 'returns a string error if not given an array of length 2' do
      string_error = 'Location must be an array of length 2'
      location = [1]

      location_contents = gameboard.update_board(location, @mock_piece)
      expect(location_contents).to eq(string_error)
    end

    it 'returns a string error if coordinates are not on the gameboard' do
      string_error = 'Invalid coordinates'
      location = [8, 8]

      location_contents = gameboard.update_board(location, @mock_piece)
      expect(location_contents).to eq(string_error)
    end

    it 'returns a string error if coordinates are negative' do
      string_error = 'Invalid coordinates'
      location = [-1, -1]

      location_contents = gameboard.update_board(location, @mock_piece)
      expect(location_contents).to eq(string_error)
    end

    it 'updates the board from default state' do
      row = rand(0..7)
      column = rand(0..7)
      gameboard.board_array[row][column] = "\00B7"
      expect(gameboard.board_array[row][column]).to eq("\00B7")

      location = [row, column]
      location_contents = gameboard.update_board(location, @mock_piece)

      expect(location_contents).to eq("\u265C") # Solid Rook
    end

    it 'can reset the position when already displaying a piece' do
      row = rand(0..7)
      column = rand(0..7)
      gameboard.board_array[row][column] = "\u2658" # Oulined Knight
      expect(gameboard.board_array[row][column]).to eq("\u2658") # Oulined Knight

      location = [row, column]
      location_contents = gameboard.update_board(location, @mock_piece)

      expect(location_contents).to eq("\u265C") # Solid Rook
    end
  end

  describe '#update_piece_location' do
    let(:gameboard) { described_class.new }

    it 'should update the value for the given piece-key to its new location' do
      p1_pieces_mock = { 'pawn1': [2, 1], 'pawn2': [2, 2] }

      piece = 'pawn1'
      new_location = [3, 1]
      expected_pieces_hash = { 'pawn1': [3, 1], 'pawn2': [2, 2] }

      returned_hash = gameboard.update_piece_location(p1_pieces_mock, piece, new_location)

      expect(returned_hash).to eq(expected_pieces_hash)
    end
  end
end
