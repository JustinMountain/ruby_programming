# frozen_string_literal: true

require_relative '../lib/queen'

RSpec.describe Queen do
  describe '#valid_moves' do
    let(:test_queen) { described_class.new }

    context 'an invalid start location' do
      it "should return a string containing 'Error'" do
        invalid_start = [2, 2, 2]
        board = instance_double('board')

        error_condition = test_queen.valid_moves(invalid_start, board)
        error_message = 'Error'

        expect(error_condition).to eq(error_message)
      end
    end
  end

  describe '#all_moves' do
    let(:test_queen) { described_class.new }

    context 'there is a queen at 1, 1 for player 1 on an empty board' do
      it 'should return an array of 56 move locations' do
        start_location = [1, 1]
        all_moves = test_queen.all_moves(start_location)

        expect(all_moves.length).to be(56)
        # These 28 positions are limited to valid board locations in possible_moves
      end

      it 'should return [2, 2] for the first move location [0]' do
        start_location = [1, 1]
        all_moves = test_queen.all_moves(start_location)
        first_move = all_moves[0]
        expected = [2, 2]

        expect(first_move).to eq(expected)
      end

      it 'should return [4, 4] for the third move location [2]' do
        start_location = [1, 1]
        all_moves = test_queen.all_moves(start_location)
        third_move = all_moves[2]
        expected = [4, 4]

        expect(third_move).to eq(expected)
      end

      it 'should return [8, -6] for the final move location [55]' do
        start_location = [1, 1]
        all_moves = test_queen.all_moves(start_location)
        third_move = all_moves[55]
        expected = [1, -6]

        expect(third_move).to eq(expected)
      end
    end
  end
end
