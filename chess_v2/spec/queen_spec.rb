# frozen_string_literal: true

require_relative '../lib/queen'

RSpec.describe Queen do
  describe '#initialize' do
    context 'Player 1' do
      let(:queen) { described_class.new('Player1', [1, 1]) }

      # it 'should store the queen movement array' do
      #   expected_array = []
      #   returned_array = queen.moves_array

      #   expect(returned_array).to eq(expected_array)
      # end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265B"
        returned_marker = queen.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:queen) { described_class.new('Player2', [1, 1]) }

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2655"
        returned_marker = queen.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end
end
