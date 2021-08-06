# frozen_string_literal: true

require_relative '../lib/chessboard'

RSpec.describe ChessBoard do
  describe '#initialize' do
    let(:test_board) { described_class.new }

    it 'should create the gameboard array of length 8 (representing 8 rows)' do
      expect(test_board.board.length).to be(8)
    end

    it 'should create an array of length 8 at each index (representing 8 columns)' do
      row = 3
      expect(test_board.board[row].length).to be(8)
    end

    it 'should return nil at each location' do
      row = 6
      column = 1
      expect(test_board.board[row][column]).to be_nil
    end
  end

  describe '#init_nodes' do
    let(:test_board) { described_class.new }

    before do 
      test_board.init_nodes
    end

    it 'should create a ChessNode object in each location of the Chessboard' do
      row = 1
      column = 4
      expect(test_board.board[row][column]).to be_a(ChessNode)
    end
  end

  describe '#draw_row' do
    let(:test_board) { described_class.new }

    before do
      test_board.init_nodes
    end

    it 'should return a string containing the 8 node markers to be printed to the console' do
      index = 3
      row = test_board.board[index]
      test_row = test_board.draw_row(row, index)

      expect(test_row).to be_a(String)
    end
  end

  describe '#draw_game' do
    let(:test_board) { described_class.new }

    before do
      test_board.init_nodes
    end

    it 'should draw to the console and return the board array of arrays' do
      drawn = test_board.draw_game

      expect(drawn).to be_a(Array)
    end
  end
end
