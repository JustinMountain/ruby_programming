# frozen_string_literal: true

require_relative '../lib/knight'

RSpec.describe Knight do
  describe '#valid_moves' do
    let(:test_knight) { described_class.new }

    context 'an invalid start location' do
      it "should return a string containing 'Error'" do
        invalid_start = [2, 2, 2]
        board = instance_double('board')

        error_condition = test_knight.valid_moves(invalid_start, board)
        error_message = 'Error'

        expect(error_condition).to eq(error_message)
      end
    end
  end

  describe '#all_moves' do
    let(:test_knight) { described_class.new }

    context 'there is a knight at 1, 1' do
      it 'should return an array of 8 move locations' do
        start_location = [1, 1]
        all_moves = test_knight.all_moves(start_location)

        expect(all_moves.length).to be(8)
      end

      it 'should return [0, 3] for the first move location [0]' do
        start_location = [1, 1]
        all_moves = test_knight.all_moves(start_location)
        first_move = all_moves[0]
        expected = [0, 3]

        expect(first_move).to eq(expected)
      end

      it 'should return [-1, 0]for the third move location [2]' do
        start_location = [1, 1]
        all_moves = test_knight.all_moves(start_location)
        third_move = all_moves[2]
        expected = [-1, 0]

        expect(third_move).to eq(expected)
      end

      it 'should return [2, -1] for the last move location [7]' do
        start_location = [1, 1]
        all_moves = test_knight.all_moves(start_location)
        last_move = all_moves[7]
        expected = [2, -1]

        expect(last_move).to eq(expected)
      end
    end

    context 'there is a knight at 5, 5' do
      it 'should return an array of 8 move locations' do
        start_location = [5, 5]
        all_moves = test_knight.all_moves(start_location)

        expect(all_moves.length).to be(8)
      end

      it 'should return [4, 7] for the first move location [0]' do
        start_location = [5, 5]
        all_moves = test_knight.all_moves(start_location)
        first_move = all_moves[0]
        expected = [4, 7]

        expect(first_move).to eq(expected)
      end

      it 'should return [3, 4] for the third move location [2]' do
        start_location = [5, 5]
        all_moves = test_knight.all_moves(start_location)
        third_move = all_moves[2]
        expected = [3, 4]

        expect(third_move).to eq(expected)
      end

      it 'should return [6, 3] for the last move location [7]' do
        start_location = [5, 5]
        all_moves = test_knight.all_moves(start_location)
        last_move = all_moves[7]
        expected = [6, 3]

        expect(last_move).to eq(expected)
      end
    end
  end

  describe '#possible_moves' do
    let(:test_knight) { described_class.new }

    context 'there is a knight at 1, 1' do
      it 'should return an array of 2 move locations' do
        all_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
        possible = test_knight.possible_moves(all_moves)

        expect(possible.length).to be(2)
      end

      it 'should have [2, 3] as the first possible move [0]' do
        all_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
        possible = test_knight.possible_moves(all_moves)
        first = possible[0]
        expected = [2, 3]

        expect(first).to eq(expected)
      end

      it 'should have [3, 2] as the second possible move [1]' do
        all_moves = [[0, 3], [-1, 2], [-1, 0], [0, -1], [2, 3], [3, 2], [3, 0], [2, -1]]
        possible = test_knight.possible_moves(all_moves)
        second = possible[1]
        expected = [3, 2]

        expect(second).to eq(expected)
      end
    end
  end

  describe '#move' do
    let(:test_knight) { described_class.new }

    context 'an invalid start location' do
      it 'returns the error message if not given an array' do
        start = 0
        finish = [5, 5]
        board = instance_double('board', { board: [[0, 0], [1, 1]] })
        error_message = 'Invalid start location'

        invalid = test_knight.move(start, finish, board)

        expect(invalid).to eq(error_message)
      end

      it 'returns the error message if given an array longer than 2' do
        start = [0, 5, 2]
        finish = [5, 5]
        board = instance_double('board', { board: [[0, 0], [1, 1]] })
        error_message = 'Invalid start location'

        invalid = test_knight.move(start, finish, board)

        expect(invalid).to eq(error_message)
      end

      it 'returns the error message if given an array shorter than 2' do
        start = [0]
        finish = [5, 5]
        board = instance_double('board', { board: [[0, 0], [1, 1]] })
        error_message = 'Invalid start location'

        invalid = test_knight.move(start, finish, board)

        expect(invalid).to eq(error_message)
      end
    end

    context 'an invalid finish location' do
      it 'returns the error message if not given an array' do
        start = [5, 5]
        finish = 0
        board = instance_double('board', { board: [[0, 0], [1, 1]] })
        error_message = 'Invalid finish location'

        invalid = test_knight.move(start, finish, board)

        expect(invalid).to eq(error_message)
      end

      it 'returns the error message if given an array longer than 2' do
        start = [5, 5]
        finish = [1, 1, 1]
        board = instance_double('board', { board: [[0, 0], [1, 1]] })
        error_message = 'Invalid finish location'

        invalid = test_knight.move(start, finish, board)

        expect(invalid).to eq(error_message)
      end

      it 'returns the error message if given an array shorter than 2' do
        start = [5, 5]
        finish = [1]
        board = instance_double('board', { board: [[0, 0], [1, 1]] })
        error_message = 'Invalid finish location'

        invalid = test_knight.move(start, finish, board)

        expect(invalid).to eq(error_message)
      end
    end
  end

  # describe '#check_validity' do
  #   let(:test_knight) { described_class.new }

  #   context 'an invalid move location' do
  #     it 'returns the appropriate error message' do
  #       start = [1, 1]
  #       finish = [3, 3]
  #       board = instance_double('board', { board: board.board[row][column].owner = '' })
  #       instance_double('valid_moves', { valid_moves: [[2, 3], [3, 2]] })
  #       error_message = 'Invalid move'

  #       invalid = test_knight.move(start, finish, board)

  #       expect(invalid).to eq(error_message)
  #     end
  #   end
  # end
end
