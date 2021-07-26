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
end
