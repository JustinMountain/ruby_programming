# frozen_string_literal: true

require_relative '../lib/knight'

RSpec.describe Knight do
  describe '#initialize' do
    context 'Player 1' do
      let(:knight) { described_class.new('Player1', [1, 1]) }

      it 'should store the knight movement array' do
        expected_array = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, 2], [2, 1], [2, -1], [1, -2]]
        returned_array = knight.moves_array

        expect(returned_array).to eq(expected_array)
      end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265E"
        returned_marker = knight.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:knight) { described_class.new('Player2', [1, 1]) }

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2658"
        returned_marker = knight.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end
end
