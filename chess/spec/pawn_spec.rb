# frozen_string_literal: true

require_relative '../lib/pawn'

RSpec.describe Pawn do
  describe '#valid_moves' do
    let(:test_pawn) { described_class.new }

    context 'an invalid start location' do
      it "should return a string containing 'Error'" do
        invalid_start = [2, 2, 2]
        board = instance_double('board')

        error_condition = test_pawn.valid_moves(invalid_start, board)
        error_message = 'Error'

        expect(error_condition).to eq(error_message)
      end
    end
  end

  describe '#all_moves' do
    let(:test_pawn) { described_class.new }

    context 'there is a pawn at 1, 1 for player 1' do
      it 'should return an array of 3 move locations' do
        start_location = [1, 1]
        directed_moves = [[1, -1], [1, 0], [1, 1]]
        all_moves = test_pawn.all_moves(start_location, directed_moves)

        expect(all_moves.length).to be(3)
      end

      it 'should return [2, 0] for the first move location [0]' do
        start_location = [1, 1]
        directed_moves = [[1, -1], [1, 0], [1, 1]]
        all_moves = test_pawn.all_moves(start_location, directed_moves)
        first_move = all_moves[0]
        expected = [2, 0]

        expect(first_move).to eq(expected)
      end

      it 'should return [2, 2]for the third move location [2]' do
        start_location = [1, 1]
        directed_moves = [[1, -1], [1, 0], [1, 1]]
        all_moves = test_pawn.all_moves(start_location, directed_moves)
        third_move = all_moves[2]
        expected = [2, 2]

        expect(third_move).to eq(expected)
      end
    end

    context 'there is a pawn at 5, 5 for player 2' do
      it 'should return an array of 3 move locations' do
        start_location = [5, 5]
        directed_moves = [[1, -1], [1, 0], [1, 1]]
        all_moves = test_pawn.all_moves(start_location, directed_moves)

        expect(all_moves.length).to be(3)
      end

      it 'should return [6, 4] for the first move location [0]' do
        start_location = [5, 5]
        directed_moves = [[1, -1], [1, 0], [1, 1]]
        all_moves = test_pawn.all_moves(start_location, directed_moves)
        first_move = all_moves[0]
        expected = [6, 4]

        expect(first_move).to eq(expected)
      end

      it 'should return [6, 6] for the third move location [2]' do
        start_location = [5, 5]
        directed_moves = [[1, -1], [1, 0], [1, 1]]
        all_moves = test_pawn.all_moves(start_location, directed_moves)
        third_move = all_moves[2]
        expected = [6, 6]

        expect(third_move).to eq(expected)
      end
    end
  end

  describe '#determine movement' do
    let(:test_pawn) { described_class.new }

    it 'should a return positive array for Player1 in start position' do
      player = 'Player1'
      start = [1, 1]
      expected_array = [[1, -1], [1, 0], [1, 1], [2, 0]]

      determined = test_pawn.determine_movement(player, start)

      expect(determined).to eq(expected_array)
    end

    it 'should a return positive array for Player1 in any other position' do
      player = 'Player1'
      start = [3, 1]
      expected_array = [[1, -1], [1, 0], [1, 1]]

      determined = test_pawn.determine_movement(player, start)

      expect(determined).to eq(expected_array)
    end

    it 'should a return negative array for Player2 in start position' do
      player = 'Player2'
      start = [6, 1]

      expected_array = [[-1, -1], [-1, 0], [-1, 1], [-2, 0]]

      determined = test_pawn.determine_movement(player, start)

      expect(determined).to eq(expected_array)
    end

    it 'should a return negative array for Player2 in any other position' do
      player = 'Player2'
      start = [3, 1]

      expected_array = [[-1, -1], [-1, 0], [-1, 1]]

      determined = test_pawn.determine_movement(player, start)

      expect(determined).to eq(expected_array)
    end
  end

  describe '#player_correction' do
    let(:test_pawn) { described_class.new }

    context 'there is no player piece at any intended location' do
      it 'should return the same array of possible moves'
    end

    context 'there is an opponent piece at the intended location' do
      it 'should return the same array of possible moves'
    end

    context 'there is a player-owned piece at the intended location' do
      it 'should remove the square from the array of possible moves'
    end
  end
end
