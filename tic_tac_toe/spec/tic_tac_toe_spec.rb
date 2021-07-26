require_relative '../lib/tic_tac_toe.rb'

RSpec.describe GameSquare do
  describe '#initialize' do
    context 'when we create a game square' do
      let(:square) { described_class.new("test_square") }

      it 'should contain a space as content' do
        expect(square.content).to eq(" ")
      end

      it 'should be a playable square' do
        expect(square.is_playable).to be(true)
      end
    end
  end

  describe '#play' do
    let(:square) { described_class.new("test_square") }

    context 'when the square is playable' do
      context 'when Player1 chooses the square' do
        before do
          square.play("Player1")
        end

        it 'should become unplayable' do
          expect(square.is_playable).to be(false)
        end
  
        it 'should update content to "x" for Player 1' do 
          expect(square.content).to eq("x")
        end
      end

      context 'when Player2 chooses the square' do
        before do
          square.play("Player2")
        end

        it 'should update content to "o" for Player 2' do
          expect(square.content).to eq("o")
        end
      end
    end

    context 'when the square is unplayable' do
      before do
        square.play("Player1")
      end

      it 'should print out a prompt asking the player to choose again' do
        error_message = "That square is already taken, please choose another.\n"
        expect do
          square.play("Player")
        end.to output(error_message).to_stdout
      end
    end
  end
end

RSpec.describe GameBoard do
  describe '#initialize' do
    it 'should create 9 instances of GameSquare'
    
    it 'should call update_board function' do
      expect(subject).to receive(:update_board)
    end
  end

  describe '#update_board' do
    it 'should call check_winner function' do
      expect(subject).to receive(:check_winner)
    end
  end
end