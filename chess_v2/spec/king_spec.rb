# frozen_string_literal: true

require_relative '../lib/king'

RSpec.describe King do
  describe '#initialize' do
    context 'Player 1' do
      let(:king) { described_class.new('Player1', [1, 1]) }

      it 'should store the king movement array' do
        expected_array = [
          [1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]
        ]
        returned_array = king.moves_array

        expect(returned_array).to eq(expected_array)
      end
    end
  end

  describe '#update_marker' do
    context 'Player 1' do
      let(:king) { described_class.new('Player1', [1, 1]) }

      before do
        king.update_marker
      end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265A"
        returned_marker = king.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:king) { described_class.new('Player2', [1, 1]) }

      before do
        king.update_marker
      end

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2654"
        returned_marker = king.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end

  describe '#piece_specific_restrictions' do
    let(:king) { described_class.new('Player1', [1, 1]) }

    context 'there is an empty game board' do
      it 'returns 8 possible move locations' do
        empty_board = [
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265A", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: empty_board)
        own_piece_adjusted_moves = [
          [2, 1], [0, 1], [1, 2], [1, 0], [2, 2], [0, 0], [2, 0], [0, 2]
        ]
        returned_array = king.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(own_piece_adjusted_moves)
        expect(returned_array.length).to eq(8)
      end
    end

    context 'is surrounded by its own pieces' do
      it 'returns 0 possible move locations' do
        current_board = [
          ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265A", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = []
        expected_return = []
        returned_array = king.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(0)
      end
    end

    context 'its own pieces are at the end of each row and column' do
      it 'returns 3 possible move locations' do
        current_board = [
          ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"],
          ["\u265F", "\u265A", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = [
          [2, 1], [0, 1], [1, 2], [1, 0], [2, 2], [0, 0], [2, 0], [0, 2]
        ]
        expected_return = [
          [2, 1], [1, 2], [2, 2]
        ]
        returned_array = king.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(3)
      end
    end

    context 'is surrounded by the other players pieces' do
      it 'returns 8 possible move locations' do
        current_board = [
          ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265A", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = [
          [2, 1], [0, 1], [1, 2], [1, 0], [2, 2], [0, 0], [2, 0], [0, 2]
        ]
        expected_return = [[2, 1], [0, 1], [1, 2], [1, 0], [2, 2], [0, 0], [2, 0], [0, 2]]
        returned_array = king.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(8)
      end
    end

    context 'the other players pieces are at the end of each row and column' do
      it 'returns 8 possible move locations' do
        current_board = [
          ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265A", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = [
          [2, 1], [0, 1], [1, 2], [1, 0], [2, 2], [0, 0], [2, 0], [0, 2]
        ]
        returned_array = king.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(own_piece_adjusted_moves)
        expect(returned_array.length).to eq(8)
      end
    end
  end
end
