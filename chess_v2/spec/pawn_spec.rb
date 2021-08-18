# frozen_string_literal: true

require_relative '../lib/pawn'

RSpec.describe Pawn do
  describe '#initialize' do
    context 'Player 1' do
      let(:pawn) { described_class.new('Player1', [1, 1]) }

      it 'should store the pawn movement array' do
        expected_array = [
          [2, 0], [1, 0], [1, -1], [1, 1]
        ]
        returned_array = pawn.moves_array

        expect(returned_array).to eq(expected_array)
      end
    end

    context 'Player 2' do
      let(:pawn) { described_class.new('Player2', [6, 1]) }

      it 'should store the pawn movement array' do
        expected_array = [
          [-2, 0], [-1, 0], [-1, -1], [-1, 1]
        ]
        returned_array = pawn.moves_array

        expect(returned_array).to eq(expected_array)
      end
    end
  end

  describe '#update_marker' do
    context 'Player 1' do
      let(:pawn) { described_class.new('Player1', [1, 1]) }

      before do
        pawn.update_marker
      end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265F"
        returned_marker = pawn.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:pawn) { described_class.new('Player2', [1, 1]) }

      before do
        pawn.update_marker
      end

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2659"
        returned_marker = pawn.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end

  describe '#piece_specific_restrictions' do
    context 'the Player 1 piece is in the initialized position' do
      let(:pawn) { described_class.new('Player1', [1, 1]) }

      context 'there is an empty game board' do
        it 'returns 2 possible move locations' do
          empty_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: empty_board)
          own_piece_adjusted_moves = [
            [2, 1], [3, 1], [2, 0], [2, 2]
          ]
          expected_return = [[2, 1], [3, 1]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end

      context 'is surrounded by its own pieces' do
        it 'returns 0 possible move locations' do
          current_board = [
            ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
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
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(0)
        end
      end

      context 'its own pieces are at the end of each row and column' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"],
            ["\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [2, 1], [3, 1], [2, 2]
          ]
          expected_return = [
            [2, 1], [3, 1]
          ]
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end

      context 'is surrounded by the other players pieces' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u265F", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [2, 1], [3, 1], [2, 0], [2, 2]
          ]
          expected_return = [[2, 0], [2, 2]]
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end

      context 'the other players pieces are at the end of each row and column' do
        it 'returns 3 possible move locations' do
          current_board = [
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [2, 1], [3, 1], [2, 0], [2, 2]
          ]
          expected_return = [[2, 1], [3, 1], [2, 0]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(3)
        end
      end

      context 'the other players pieces are at the end of each row and column and and opponent piece is 2 squares ahead' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [2, 1], [3, 1], [2, 0], [2, 2]
          ]
          expected_return = [[2, 1], [2, 0]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end
    end

    context 'the Player 1 piece is NOT in the initialized position' do
      let(:pawn) { described_class.new('Player1', [4, 1]) }

      context 'there is an empty game board' do
        it 'returns 1 possible move locations' do
          empty_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: empty_board)
          own_piece_adjusted_moves = [
            [5, 1], [5, 0], [5, 2]
          ]
          expected_return = [[5, 1]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(1)
        end
      end

      context 'is surrounded by the other players pieces' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u265F", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [5, 1], [5, 0], [5, 2]
          ]
          expected_return = [[5, 0], [5, 2]]
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end
    end

    context 'the Player 2 piece is in the initialized position' do
      let(:pawn) { described_class.new('Player2', [6, 1]) }

      context 'there is an empty game board' do
        it 'returns 2 possible move locations' do
          empty_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: empty_board)
          own_piece_adjusted_moves = [
            [5, 1], [4, 1], [5, 0], [5, 2]
          ]
          expected_return = [[5, 1], [4, 1]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end

      context 'is surrounded by its own pieces' do
        it 'returns 0 possible move locations' do
          current_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u2659", "\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = []
          expected_return = []
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(0)
        end
      end

      context 'its own pieces are at the end of each row and column' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659"],
            ["\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u2659"],
            ["\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [5, 1], [4, 1], [5, 2]
          ]
          expected_return = [
            [5, 1], [4, 1]
          ]
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end

      context 'is surrounded by the other players pieces' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u265F", "\u2659", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [5, 1], [4, 1], [5, 0], [5, 2]
          ]
          expected_return = [[5, 0], [5, 2]]
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end

      context 'the other players pieces are at the end of each row and column' do
        it 'returns 3 possible move locations' do
          current_board = [
            ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"],
            ["\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [5, 1], [4, 1], [5, 0], [5, 2]
          ]
          expected_return = [[5, 1], [4, 1], [5, 0]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(3)
        end
      end

      context 'the other players pieces are at the end of each row and column and and opponent piece is 2 squares ahead' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"],
            ["\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u265F"],
            ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [5, 1], [4, 1], [5, 0], [5, 2]
          ]
          expected_return = [[5, 1], [5, 0]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end
    end

    context 'the Player 2 piece is NOT in the initialized position' do
      let(:pawn) { described_class.new('Player2', [4, 1]) }

      context 'there is an empty game board' do
        it 'returns 1 possible move locations' do
          empty_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u2659", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: empty_board)
          own_piece_adjusted_moves = [
            [3, 1], [3, 0], [3, 2]
          ]
          expected_return = [[3, 1]]

          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(1)
        end
      end

      context 'is surrounded by the other players pieces' do
        it 'returns 2 possible move locations' do
          current_board = [
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u265F", "\u2659", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u265F", "\u265F", "\u265F", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"],
            ["\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7", "\u00B7"]
          ]
          board_double = double('board_double', return_board: current_board)
          own_piece_adjusted_moves = [
            [3, 1], [3, 0], [3, 2]
          ]
          expected_return = [[3, 0], [3, 2]]
          returned_array = pawn.piece_specific_restrictions(board_double, own_piece_adjusted_moves)

          expect(returned_array).to eq(expected_return)
          expect(returned_array.length).to eq(2)
        end
      end
    end
  end
end
