# frozen_string_literal: true

require_relative '../lib/piece'

RSpec.describe Piece do
  describe '#move' do
    let(:piece) { described_class.new('Player1', [1, 1]) }

    it 'calls the board methods to update the start and finish locations' do
      board_double = double('board_double', update_board: 'some_marker', reset_location_marker: 'some_marker')
      start = [1, 1]
      finish = [2, 1]

      expect(board_double).to receive(:update_board).once
      expect(board_double).to receive(:reset_location_marker).once

      piece.move(board_double, start, finish)
    end
  end

  describe '#moves_from_start' do
    let(:piece) { described_class.new('Player1', [1, 1]) }

    it 'returns an array of length 8 for a piece starting at any board location' do
      start = piece.location
      start_adjusted_moves = piece.moves_from_start(start)

      expect(start_adjusted_moves.length).to eq(8)
    end

    it 'has [0, 3] as the first array index' do
      start = piece.location
      start_adjusted_moves = piece.moves_from_start(start)

      expect(start_adjusted_moves[0]).to eq([0, 3])
    end

    it 'has [0, -1] as the fourth array index' do
      start = piece.location
      start_adjusted_moves = piece.moves_from_start(start)

      expect(start_adjusted_moves[3]).to eq([0, -1])
    end

    it 'has [2, -1] as the last array index' do
      start = piece.location
      start_adjusted_moves = piece.moves_from_start(start)

      expect(start_adjusted_moves[7]).to eq([2, -1])
    end
  end

  describe '#remove_invalid_coordinates' do
    context 'the piece starts at [1, 1]' do
      let(:piece) { described_class.new('Player1', [1, 1]) }

      it 'removes all row and column positions less than 0' do
        start_adjusted_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
        expected_return = [[0, 3], [2, 3], [3, 2], [3, 0]]

        board_adjusted_moves = piece.remove_invalid_coordinates(start_adjusted_moves)

        expect(board_adjusted_moves).to eq(expected_return)
      end
    end

    context 'the piece starts at [7, 7]' do
      let(:piece) { described_class.new('Player1', [7, 7]) }

      it 'removes all row and column positions greater than 7' do
        start_adjusted_moves = [[7, 10], [6, 9], [6, 7], [7, 6], [9, 10], [10, 9], [10, 7], [9, 6]]

        expected_return = [[6, 7], [7, 6]]

        board_adjusted_moves = piece.remove_invalid_coordinates(start_adjusted_moves)

        expect(board_adjusted_moves).to eq(expected_return)
      end
    end
  end

  describe '#remove_own_piece_locations' do
    let(:piece) { described_class.new('Player1', [1, 1]) }

    it 'should remove a location from the array if present in players own piece array' do
      board_double = double('board_double', return_player_pieces: { pawn1: [2, 3], pawn2: [3, 3] })

      board_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      expected_return = [[0, 3], [3, 2], [3, 0]]
      player = piece.player

      own_piece_adjusted_moves = piece.remove_own_piece_locations(board_double, player, board_adjusted_moves)
      expect(own_piece_adjusted_moves).to eq(expected_return)
    end

    it 'should return an identical array if player does not have pieces at desired locaations' do
      board_double = double('board_double', return_player_pieces: { pawn1: [1, 3], pawn2: [3, 3] })

      board_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      expected_return = [[0, 3], [2, 3], [3, 2], [3, 0]]
      player = piece.player

      own_piece_adjusted_moves = piece.remove_own_piece_locations(board_double, player, board_adjusted_moves)
      expect(own_piece_adjusted_moves).to eq(expected_return)
    end
  end

  describe '#piece_specific_restrictions' do
    let(:piece) { described_class.new('Player1', [1, 1]) }

    it 'should return the same array for this default piece' do
      own_piece_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      expected_return = [[0, 3], [2, 3], [3, 2], [3, 0]]

      expect(expected_return).to eq(own_piece_adjusted_moves)
    end
  end

  describe '#valid_move?' do
    let(:piece) { described_class.new('Player1', [1, 1]) }

    it 'should return true if the move is valid' do
      board_double = double('board_double', return_player_pieces: { pawn1: [1, 3], pawn2: [3, 3] })
      player = piece.player
      start = piece.location
      finish = [2, 3]
      start_adjusted_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
      board_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      own_piece_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      piece_restricted = [[0, 3], [2, 3], [3, 2], [3, 0]]

      allow(piece).to receive(:moves_from_start).and_return(start_adjusted_moves)
      allow(piece).to receive(:remove_invalid_coordinates).and_return(board_adjusted_moves)
      allow(piece).to receive(:remove_own_piece_locations).and_return(own_piece_adjusted_moves)
      allow(piece).to receive(:piece_specific_restrictions).and_return(piece_restricted)

      valid = piece.valid_move?(board_double, player, start, finish)
      expect(valid).to be(true)
    end

    it 'should return false if the finish location is not on the board' do
      board_double = double('board_double', return_player_pieces: { pawn1: [2, 3], pawn2: [3, 3] })
      player = piece.player
      start = piece.location
      finish = [8, 8]
      start_adjusted_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
      board_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      own_piece_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      piece_restricted = [[0, 3], [2, 3], [3, 2], [3, 0]]

      allow(piece).to receive(:moves_from_start).and_return(start_adjusted_moves)
      allow(piece).to receive(:remove_invalid_coordinates).and_return(board_adjusted_moves)
      allow(piece).to receive(:remove_own_piece_locations).and_return(own_piece_adjusted_moves)
      allow(piece).to receive(:piece_specific_restrictions).and_return(piece_restricted)

      valid = piece.valid_move?(board_double, player, start, finish)
      expect(valid).to be(false)
    end

    it 'should return false if the player already owns the piece at the finish location' do
      board_double = double('board_double', return_player_pieces: { pawn1: [2, 3], pawn2: [3, 3] })
      player = piece.player
      start = piece.location
      finish = [2, 3]
      start_adjusted_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
      board_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      own_piece_adjusted_moves = [[0, 3], [3, 2], [3, 0]]
      piece_restricted = [[0, 3], [3, 2], [3, 0]]

      allow(piece).to receive(:moves_from_start).and_return(start_adjusted_moves)
      allow(piece).to receive(:remove_invalid_coordinates).and_return(board_adjusted_moves)
      allow(piece).to receive(:remove_own_piece_locations).and_return(own_piece_adjusted_moves)
      allow(piece).to receive(:piece_specific_restrictions).and_return(piece_restricted)

      valid = piece.valid_move?(board_double, player, start, finish)
      expect(valid).to be(false)
    end

    it 'should return false if the piece prevents movement to the finish location' do 
      board_double = double('board_double', return_player_pieces: { pawn1: [2, 3], pawn2: [3, 3] })
      player = piece.player
      start = piece.location
      finish = [2, 3]
      start_adjusted_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
      board_adjusted_moves = [[0, 3], [2, 3], [3, 2], [3, 0]]
      own_piece_adjusted_moves = [[0, 3], [3, 2], [3, 0]]
      piece_restricted = []

      allow(piece).to receive(:moves_from_start).and_return(start_adjusted_moves)
      allow(piece).to receive(:remove_invalid_coordinates).and_return(board_adjusted_moves)
      allow(piece).to receive(:remove_own_piece_locations).and_return(own_piece_adjusted_moves)
      allow(piece).to receive(:piece_specific_restrictions).and_return(piece_restricted)

      valid = piece.valid_move?(board_double, player, start, finish)
      expect(valid).to be(false)
    end
  end
end
