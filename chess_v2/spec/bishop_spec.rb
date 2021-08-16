# frozen_string_literal: true

require_relative '../lib/bishop'

RSpec.describe Bishop do
  describe '#initialize' do
    context 'Player 1' do
      let(:bishop) { described_class.new('Player1', [1, 1]) }

      # it 'should store the bishop movement array' do
      #   expected_array = []
      #   returned_array = bishop.moves_array

      #   expect(returned_array).to eq(expected_array)
      # end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265D"
        returned_marker = bishop.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:bishop) { described_class.new('Player2', [1, 1]) }

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2657"
        returned_marker = bishop.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end
end
