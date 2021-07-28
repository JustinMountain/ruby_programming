# frozen_string_literal: true

require_relative '../lib/gameboard'

RSpec.describe GameBoard do
  describe '#initialize' do
    let(:test_board) { described_class.new }

    it 'should create an array of length 6 (representing 6 rows)' do
      expect(test_board.board.length).to be(6)
    end

    it 'should have an array of length 7 at each index (representing 7 columns)' do
      expect(test_board.board[0].length).to be(7)
    end

    it 'should have a space in each index' do
      expect(test_board.board[0][0]).to eq(' ')
    end
  end

  context 'a new game state' do
    let(:test_board) { described_class.new }

    describe '#draw_row' do
      it 'should return the expected string to print' do
        test_row = test_board.board[0]
        string_output = test_board.draw_row(test_row)
        expected = ' |   |   |   |   |   |   |   | '

        expect(string_output).to eq(expected)
      end
    end
  end

  context 'player1 plays their turn'

  describe '#play' do
    let(:test_board) { described_class.new }

    context 'play in column' do
      column = 3
      marker1 = 'X'
      marker2 = 'O'

      context 'the bottom row is empty' do
        it 'should place a marker in the bottom row' do
          test_board.play(marker1, column)
          expect(test_board.board[5][column]).to eq(marker1)
        end
      end

      context 'the bottom row is occupied' do
        before do
          test_board.play(marker1, column)
        end

        it 'should place the piece in the next available spot' do
          test_board.play(marker2, column)
          expect(test_board.board[4][column]).to eq(marker2)
        end
      end

      context 'the column is full' do
        before do
          test_board.play(marker1, column)
          test_board.play(marker2, column)
          test_board.play(marker1, column)
          test_board.play(marker2, column)
          test_board.play(marker1, column)
          test_board.play(marker2, column)
        end

        it 'should not allow a marker to be placed in the column is full' do
          receive_error = test_board.play(marker1, column)
          error_message = 'Invalid choice: This column is already full.'
          expect(receive_error).to eq(error_message)
        end
      end
    end
  end
end
