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
  end

  describe '#update_board' do
  end

  describe '#update_piece_location' do
  end
end
