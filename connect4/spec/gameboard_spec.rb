# frozen_string_literal: true

require_relative '../lib/gameboard'

RSpec.describe GameBoard do
  describe '#initialize' do
    let(:test_board) { described_class.new }

    it 'should create an array of length 6 (representing 6 rows)' do
      expect(test_board.board.length).to be(6)
    end

    it 'should have an array of length 7 at each index (representing 7 columns)' do
      expect(test_board.board[0].length).to be(7)
    end

    it 'should have a space in each index' do
      expect(test_board.board[0][0]).to eq(' ')
    end
  end

  describe '#draw_row' do
    context 'a new game state' do
      let(:test_board) { described_class.new }

      it 'should return the expected string to print' do
        test_row = test_board.board[0]
        string_output = test_board.draw_row(test_row)
        expected = ' |   |   |   |   |   |   |   | '

        expect(string_output).to eq(expected)
      end
    end
  end

  describe '#play' do
    let(:test_board) { described_class.new }

    context 'play in column' do
      column = 3
      marker1 = 'X'
      marker2 = 'O'

      context 'the bottom row is empty' do
        it 'should place a marker in the bottom row' do
          test_board.play(marker1, column)
          expect(test_board.board[5][column]).to eq(marker1)
        end
      end

      context 'the bottom row is occupied' do
        before do
          test_board.play(marker1, column)
        end

        it 'should place the piece in the next available spot' do
          test_board.play(marker2, column)
          expect(test_board.board[4][column]).to eq(marker2)
        end
      end

      context 'the column is full' do
        before do
          test_board.play(marker1, column)
          test_board.play(marker2, column)
          test_board.play(marker1, column)
          test_board.play(marker2, column)
          test_board.play(marker1, column)
          test_board.play(marker2, column)
        end

        it 'should not allow a marker to be placed in the column is full' do
          receive_error = test_board.play(marker1, column)
          error_message = 'Invalid choice: This column is already full.'
          expect(receive_error).to eq(error_message)
        end
      end
    end
  end

  describe '#stalemate?' do
    let(:test_board) { described_class.new }

    context 'the game was just initialized' do
      it 'should return false' do
        expect(test_board.stalemate?).to be(false)
      end
    end

    context 'only one column has been filled' do
      before do
        column = 3
        marker1 = 'X'
        marker2 = 'O'

        test_board.play(marker1, column)
        test_board.play(marker2, column)
        test_board.play(marker1, column)
        test_board.play(marker2, column)
        test_board.play(marker1, column)
        test_board.play(marker2, column)
      end

      it 'should return false' do
        expect(test_board.stalemate?).to be(false)
      end
    end

    context 'the top row has been filled; the game is at stalemate' do
      it 'should return true' do
        test_board.board[0] = %w[X X X O X X X]
        expect(test_board.stalemate?).to be(true)
      end
    end
  end

  describe '#horizontal_win?' do
    let(:test_board) { described_class.new }

    it 'returns false when the game has just been initialized' do
      expect(test_board.horizontal_win?).to be(false)
    end

    context 'the board is full' do
      it 'returns false when no row has 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X X X O O O X]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.horizontal_win?).to be(false)
      end

      it 'returns true when one row has 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X X X X X O O] # Winning row
        expect(test_board.horizontal_win?).to be(true)
      end
    end

    context 'looking at the bottom row' do
      it 'returns true if there are 4 of the same marker consecutively' do
        test_board.board[5] = %w[O O O O X X X]
        expect(test_board.horizontal_win?).to be(true)
      end

      it 'is false if there are not 4 of the same marker consecutively' do
        test_board.board[0] = %w[O O O X O X X]
        expect(test_board.horizontal_win?).to be(false)
      end
    end

    context 'looking at the top row' do
      it 'is true if there are 4 of the same marker consecutively' do
        test_board.board[0] = %w[O O O O X X X]
        expect(test_board.horizontal_win?).to be(true)
      end

      it 'is false if there are not 4 of the same marker consecutively' do
        test_board.board[0] = %w[O O O X O X X]
        expect(test_board.horizontal_win?).to be(false)
      end
    end
  end

  describe '#vertical_win?' do
    let(:test_board) { described_class.new }

    it 'returns false when the game has just been initialized' do
      expect(test_board.vertical_win?).to be(false)
    end

    context 'the board is full' do
      it 'returns false when no column has 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X X X O O O X]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.vertical_win?).to be(false)
      end

      it 'returns true when one column has 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X] # 4 X's down the center column
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X X X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.vertical_win?).to be(true)
      end
    end

    context 'looking at the rightmost column' do
      it 'returns true if there are 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O X]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O X]
        expect(test_board.vertical_win?).to be(true)
      end

      it 'returns false if there are not 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.vertical_win?).to be(false)
      end
    end

    context 'looking at the leftmost column' do
      it 'returns true if there are 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[O O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[O O X X X O O]
        expect(test_board.vertical_win?).to be(true)
      end

      it 'returns false if there are not 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.vertical_win?).to be(false)
      end
    end
  end

  describe '#diagonal_win?' do
    let(:test_board) { described_class.new }

    it 'returns false when the game has just been initialized' do
      expect(test_board.diagonal_win?).to be(false)
    end

    context 'the board is full' do
      it 'returns false when no diagonal has 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X X X O O O X]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.diagonal_win?).to be(false)
      end

      it 'returns true when one diagonal has 4 of the same marker consecutively' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.diagonal_win?).to be(true)
      end
    end

    context 'top-left to bottom-right' do
      it 'returns true if the diagonal is on the bottom row' do
        test_board.board[2] = %w[O]
        test_board.board[3] = %w[X O X O X O X]
        test_board.board[4] = %w[X X O X O X O]
        test_board.board[5] = %w[X X X O X O X]
        expect(test_board.diagonal_win?).to be(true)
      end

      it 'returns true if the diagonal is one up from the bottom row' do
        test_board.board[1] = %w[O]
        test_board.board[2] = %w[X O X O X O X]
        test_board.board[3] = %w[X X O X O X O]
        test_board.board[4] = %w[X X X O X O X]
        test_board.board[5] = %w[A B C D E F G]
        expect(test_board.diagonal_win?).to be(true)
      end

      it 'returns true if the diagonal starts on the top row' do
        test_board.board[0] = %w[O]
        test_board.board[1] = %w[X O X O X O X]
        test_board.board[2] = %w[X X O X O X O]
        test_board.board[3] = %w[X X X O X O X]
        test_board.board[4] = %w[A B C D E F G]
        test_board.board[5] = %w[H I J K L M N]
        expect(test_board.diagonal_win?).to be(true)
      end
    end

    context 'top-right to bottom-left' do
      it 'returns true if the diagonal is on the bottom row' do
        test_board.board[2] = %w[X O X O X O O]
        test_board.board[3] = %w[X O X O X O X]
        test_board.board[4] = %w[O X O X O X O]
        test_board.board[5] = %w[X O X O X O X]
        expect(test_board.diagonal_win?).to be(true)
      end

      it 'returns true if the diagonal is one up from the bottom row' do
        test_board.board[1] = %w[X O X O X O O]
        test_board.board[2] = %w[X O X O X O X]
        test_board.board[3] = %w[X X O X O X O]
        test_board.board[4] = %w[X X X O X O X]
        test_board.board[5] = %w[A B C D E F G]
        expect(test_board.diagonal_win?).to be(true)
      end

      it 'returns true if the diagonal starts on the top row' do
        test_board.board[0] = %w[X O X O X O O]
        test_board.board[1] = %w[X O X O X O X]
        test_board.board[2] = %w[X X O X O X O]
        test_board.board[3] = %w[X X X O X O X]
        test_board.board[4] = %w[A B C D E F G]
        test_board.board[5] = %w[H I J K L M N]
        expect(test_board.diagonal_win?).to be(true)
      end
    end
  end

  describe '#game_over?' do
    let(:test_board) { described_class.new }

    context 'the game has just been instantiated' do
      it 'returns false' do
        expect(test_board.game_over?).to be(false)
      end
    end

    context 'the game has reached a stalemate' do
      it 'returns true' do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.game_over?).to be(true)
      end
    end

    context 'the game has finished because of a horizontal win' do
      it 'returns true' do
        test_board.board[0] = %w[X X X X O X ' ']
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.game_over?).to be(true)
      end
    end

    context 'the game has finished because of a vertical win' do
      it 'returns true' do
        test_board.board[0] = %w[X X O X O ' ' ' ']
        test_board.board[1] = %w[X O X X O O ' ']
        test_board.board[2] = %w[X O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        expect(test_board.game_over?).to be(true)
      end
    end

    context 'the game has finished because of a diagonal win' do
      it 'returns true' do
        test_board.board[0] = %w[X O X O X O O]
        test_board.board[1] = %w[X O X O X O X]
        test_board.board[2] = %w[X X O X O X O]
        test_board.board[3] = %w[X X X O X O X]
        test_board.board[4] = %w[A B C D E F G]
        test_board.board[5] = %w[H I J K L M N]
        expect(test_board.game_over?).to be(true)
      end
    end
  end

  describe '#game_over_condition' do
    let(:test_board) { described_class.new }

    context 'the game has just been instantiated' do
      it "returns a string containing 'keep playing'" do
        string = 'keep playing'
        expect(test_board.game_over_condition).to eq(string)
      end
    end

    context 'there is a horizontal win condition' do
      it "returns a string containing 'horizontal'" do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X X X X O O O] # Winning row
        string = 'horizontal'
        expect(test_board.game_over_condition).to eq(string)
      end
    end

    context 'there is a vertical win condition' do
      it "returns a string containing 'horizontal'" do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[O O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[O O X X X O O]
        string = 'vertical'
        expect(test_board.game_over_condition).to eq(string)
      end
    end

    context 'there is a diagonal win condition' do
      it "returns a string containing 'horizontal'" do
        test_board.board[0] = %w[O X O X O X X]
        test_board.board[1] = %w[X O X X O O O]
        test_board.board[2] = %w[O O X O X O X]
        test_board.board[3] = %w[X O O X O O O]
        test_board.board[4] = %w[O X O O O X X]
        test_board.board[5] = %w[X O X X X O O]
        string = 'diagonal'
        expect(test_board.game_over_condition).to eq(string)
      end
    end
  end
end
