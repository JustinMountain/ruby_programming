# frozen_string_literal: true

require_relative '../lib/rook'

RSpec.describe Rook do
  describe '#initialize' do
    context 'Player 1' do
      let(:rook) { described_class.new('Player1', [1, 1]) }

      it 'should store the rook movement array' do
        expected_array = [
          [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
          [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
          [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
          [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
        ]
        returned_array = rook.moves_array

        expect(returned_array).to eq(expected_array)
      end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265C"
        returned_marker = rook.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:rook) { described_class.new('Player2', [1, 1]) }

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2656"
        returned_marker = rook.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end

  describe '#piece_specific_restrictions' do
    let(:rook) { described_class.new('Player1', [1, 1]) }

    context 'there is an empty game board' do
      it 'returns 14 possible move locations' do
        empty_board = [
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: empty_board)
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        returned_array = rook.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(own_piece_adjusted_moves)
        expect(returned_array.length).to eq(14)
      end
    end

    context 'is surrounded by its own pieces' do
      it 'returns 0 possible move locations' do
        empty_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: empty_board)
        own_piece_adjusted_moves = [
          [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]
        ]
        expected_return = []
        returned_array = rook.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(0)
      end
    end

    context 'its own pieces are at the end of each row and column' do
      it 'returns 10 possible move locations' do
        empty_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: empty_board)
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6]
        ]
        expected_return = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6]
        ]
        returned_array = rook.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(10)
      end
    end

    context 'is surrounded by the other players pieces' do
      it 'returns 4 possible move locations' do
        empty_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: empty_board)
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        expected_return = [[2, 1], [0, 1], [1, 2], [1, 0]]
        returned_array = rook.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(4)
      end
    end

    context 'the other players pieces are at the end of each row and column' do
      it 'returns 14 possible move locations' do
        empty_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: empty_board)
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        returned_array = rook.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(own_piece_adjusted_moves)
        expect(returned_array.length).to eq(14)
      end
    end
  end
end
