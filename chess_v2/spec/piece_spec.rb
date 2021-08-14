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
end
