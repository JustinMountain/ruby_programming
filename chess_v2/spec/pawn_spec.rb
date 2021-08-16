# frozen_string_literal: true

require_relative '../lib/pawn'

RSpec.describe Pawn do
  describe '#initialize' do
    context 'Player 1' do
      let(:pawn) { described_class.new('Player1', [1, 1]) }

      # it 'should store the pawn movement array' do
      #   expected_array = []
      #   returned_array = pawn.moves_array

      #   expect(returned_array).to eq(expected_array)
      # end

      it 'should store the marker appropriate for Player 1' do
        expected_marker = "\u265F"
        returned_marker = pawn.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end

    context 'Player 2' do
      let(:pawn) { described_class.new('Player2', [1, 1]) }

      it 'should store the marker appropriate for Player 2' do
        expected_marker = "\u2659"
        returned_marker = pawn.marker

        expect(returned_marker).to eq(expected_marker)
      end
    end
  end
end
