# frozen_string_literal: true

require_relative '../lib/queen'

RSpec.describe Queen do
  describe '#initialize' do
    context 'Player 1' do
      let(:queen) { described_class.new('Player1', [1, 1]) }

      it 'should store the queen movement array' do
        expected_array = [
          [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
          [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
          [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
          [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
          [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
          [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7],
          [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
          [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]
        ]
        returned_array = queen.moves_array

        expect(returned_array).to eq(expected_array)
      end
    end
  end

  describe '#update_marker' do
    context 'Player 1' do
      let(:queen) { described_class.new('Player1', [1, 1]) }

      before do
        queen.update_marker
      end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265B"
        returned_marker = queen.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:queen) { described_class.new('Player2', [1, 1]) }

      before do
        queen.update_marker
      end

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2655"
        returned_marker = queen.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end

  describe '#piece_specific_restrictions' do
    let(:queen) { described_class.new('Player1', [1, 1]) }

    context 'there is an empty game board' do
      it 'returns 23 possible move locations' do
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
          [0, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0],
          [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
          [0, 0],
          [2, 0],
          [0, 2]
        ]
        returned_array = queen.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(own_piece_adjusted_moves)
        expect(returned_array.length).to eq(23)
      end
    end

    context 'is surrounded by its own pieces' do
      it 'returns 0 possible move locations' do
        current_board = [
          ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = [
          [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]
        ]
        expected_return = []
        returned_array = queen.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(0)
      end
    end

    context 'its own pieces are at the end of each row and column' do
      it 'returns 5 possible move locations' do
        current_board = [
          ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"],
          ["\u265F", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = [
          [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]
        ]
        expected_return = [
          [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]
        ]
        returned_array = queen.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(5)
      end
    end

    context 'is surrounded by the other players pieces' do
      it 'returns 8 possible move locations' do
        current_board = [
          ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0],
          [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
          [0, 0],
          [2, 0],
          [0, 2]
        ]
        expected_return = [[2, 1], [0, 1], [1, 2], [1, 0], [2, 2], [0, 0], [2, 0], [0, 2]]
        returned_array = queen.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(expected_return)
        expect(returned_array.length).to eq(8)
      end
    end

    context 'the other players pieces are at the end of each row and column' do
      it 'returns 23 possible move locations' do
        current_board = [
          ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0],
          [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
          [0, 0],
          [2, 0],
          [0, 2]
        ]
        returned_array = queen.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

        expect(returned_array).to eq(own_piece_adjusted_moves)
        expect(returned_array.length).to eq(23)
      end
    end
  end
end
