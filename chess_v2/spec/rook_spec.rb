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
    end
  end

  describe '#update_marker' do
    context 'Player 1' do
      let(:rook) { described_class.new('Player1', [1, 1]) }

      before do
        rook.update_marker
      end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265C"
        returned_marker = rook.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:rook) { described_class.new('Player2', [1, 1]) }

      before do
        rook.update_marker
      end

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
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
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
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
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
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
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
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        board_double = double('board_double', return_board: current_board)
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

  describe '#direction_limited' do
    let(:rook) { described_class.new('Player1', [1, 1]) }

    context 'the column has no other pieces in it' do
      it 'should return 6 valid move locations using a positive column direction' do
        current_board = [
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(6)
        expect(limited_array).to eq([[2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1]])
      end

      it 'should return 1 valid move location using a negative column direction' do
        current_board = [
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([0, 1], [-1, 1], [-2, 1], [-3, 1], [-4, 1], [-5, 1], [-6, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, true, true, true, true, true, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[0, 1]])
      end
    end

    context 'the row has no other pieces in it' do
      it 'should return 6 valid move locations using a positive row direction' do
        current_board = [
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(6)
        expect(limited_array).to eq([[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]])
      end

      it 'should return 1 valid move location using a negative row direction' do
        current_board = [
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 0], [-1, 1], [-1, 2], [-1, 3], [-1, 4], [-1, 5], [-1, 6])
        allow(rook).to receive(:opponent_occupies?).and_return(false, true, true, true, true, true, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[1, 0]])
      end
    end

    context 'the piece has opponent pieces above and below it' do
      it 'should return 1 valid move location using a positive column direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(true, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[2, 1]])
      end

      it 'should return 1 valid move location using a negative column direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([0, 1], [-1, 1], [-2, 1], [-3, 1], [-4, 1], [-5, 1], [-6, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(true, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[0, 1]])
      end
    end

    # Surrounded by own pieces will break the loop because the squares won't be present in own_piece_adjusted_moves
      # This is adding the squares on the other side of the pieces, but is a case only present in testing.
    context 'the piece has own pieces above and below it' do
      it 'should return 5 valid move locations using a positive column direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(5)
        expect(limited_array).to eq([[3, 1], [4, 1], [5, 1], [6, 1], [7, 1]])
      end

      it 'should return 0 valid move locations using a negative column direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([0, 1], [-1, 1], [-2, 1], [-3, 1], [-4, 1], [-5, 1], [-6, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(0)
        expect(limited_array).to eq([])
      end
    end

    context 'the piece has opponent pieces to the left and right of it' do
      it 'should return 1 valid move location using a positive row direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8])
        allow(rook).to receive(:opponent_occupies?).and_return(true, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[1, 2]])
      end

      it 'should return 1 valid move location using a negative row direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 0], [1, -1], [1, -2], [1, -3], [1, -4], [1, -5], [1, -6])
        allow(rook).to receive(:opponent_occupies?).and_return(true, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[1, 0]])
      end
    end

    # Surrounded by own pieces will break the loop because the squares won't be present in own_piece_adjusted_moves
      # This is adding the squares on the other side of the pieces, but is a case only present in testing.
    context 'the piece has own pieces to the left and right of it' do
      it 'should return 5 valid move locations using a positive row direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(5)
        expect(limited_array).to eq([[1, 3], [1, 4], [1, 5], [1, 6], [1, 7]])
      end

      it 'should return 0 valid move locations using a negative row direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 0], [1, -1], [1, -2], [1, -3], [1, -4], [1, -5], [1, -6])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(0)
        expect(limited_array).to eq([])
      end
    end

    context 'the piece has opponent pieces at both ends of the column' do
      it 'should return 6 valid move locations using a positive column direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, true, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(6)
        expect(limited_array).to eq([[2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1]])
      end

      it 'should return 1 valid move location using a negative column direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([0, 1], [-1, 1], [-2, 1], [-3, 1], [-4, 1], [-5, 1], [-6, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(true, true, true, true, true, true, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[0, 1]])
      end
    end

    context 'the piece has own pieces at both ends of the column' do
      it 'should return 5 valid move locations using a positive column direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(5)
        expect(limited_array).to eq([[2, 1], [3, 1], [4, 1], [5, 1], [6, 1]])
      end

      it 'should return 0 valid move location using a negative column direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([0, 1], [-1, 1], [-2, 1], [-3, 1], [-4, 1], [-5, 1], [-6, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(0)
        expect(limited_array).to eq([])
      end
    end

    context 'the piece has opponent pieces at both ends of the column' do
      it 'should return 6 valid move locations using a positive column direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, true, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(6)
        expect(limited_array).to eq([[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]])
      end

      it 'should return 1 valid move location using a negative column direction' do
        current_board = [
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u2659", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 0], [1, -1], [1, -2], [1, -3], [1, -4], [1, -5], [1, -6])
        allow(rook).to receive(:opponent_occupies?).and_return(true, false, false, false, false, false, false)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(1)
        expect(limited_array).to eq([[1, 0]])
      end
    end

    context 'the piece has own pieces at both ends of the column' do
      it 'should return 5 valid move locations using a positive column direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(5)
        expect(limited_array).to eq([[2, 1], [3, 1], [4, 1], [5, 1], [6, 1]])
      end

      it 'should return 0 valid move location using a negative column direction' do
        current_board = [
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u265F", "\u265C", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
          ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
        ]
        direction = [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]
        own_piece_adjusted_moves = [
          [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
          [0, 1],
          [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [1, 0]
        ]
        restricted_array = []

        allow(rook).to receive(:adjust_position).and_return([1, 0], [1, -1], [1, -2], [1, -3], [1, -4], [1, -5], [1, -6])
        allow(rook).to receive(:opponent_occupies?).and_return(false, false, false, false, false, false, true)

        limited_array = rook.direction_limited(current_board, direction, own_piece_adjusted_moves, restricted_array)

        expect(limited_array.length).to eq(0)
        expect(limited_array).to eq([])
      end
    end
  end

  describe '#adjust_position' do
    let(:rook) { described_class.new('Player1', [1, 1]) }

    it 'modify a position passed to it by its current location' do
      expect(rook.adjust_position([1, 0])).to eq([2, 1])
      expect(rook.adjust_position([2, 0])).to eq([3, 1])
      expect(rook.adjust_position([3, 0])).to eq([4, 1])
      expect(rook.adjust_position([4, 0])).to eq([5, 1])
      expect(rook.adjust_position([0, 1])).to eq([1, 2])
      expect(rook.adjust_position([0, 2])).to eq([1, 3])
      expect(rook.adjust_position([0, 3])).to eq([1, 4])
      expect(rook.adjust_position([0, 4])).to eq([1, 5])
    end
  end

  describe '#opponent_occupies?' do
    let(:rook) { described_class.new('Player1', [1, 1]) }

    it 'should return true if passed an opponent piece' do
      location_marker = "\u2654"
      opponent_piece = rook.opponent_occupies?(location_marker)

      expect(opponent_piece).to be(true)
    end

    it 'should return false if passed a player piece' do
      location_marker = "\u265A"
      opponent_piece = rook.opponent_occupies?(location_marker)

      expect(opponent_piece).to be(false)
    end

    it 'should return false if passed an empty position' do
      location_marker = "\u00B7"
      opponent_piece = rook.opponent_occupies?(location_marker)

      expect(opponent_piece).to be(false)
    end
  end
end
