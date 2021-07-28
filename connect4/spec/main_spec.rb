# frozen_string_literal: true

require_relative '../lib/main'

RSpec.describe GameLoop do
  describe '#player_names' do
    subject(:test_game) { described_class.new }

    context 'The game is initialized with 2 players' do
      before do
        player1 = 'Justin'
        marker1 = 'O'
        player2 = 'Isca'
        marker2 = 'X'

        allow(test_game).to receive(:gets).and_return(player1, marker1, player2, marker2)
      end
  
      it "should be able to update Player 1's name" do
        p1 = test_game.players.instance_variable_get(:@player1)
        expect(p1).to eq('Justin')
      end
  
      it 'should ask Player 1 for a marker'
  
      it 'should ask for the name of Player 2'
      it 'should ask Player 2 for a marker'
  
      it 'should set active_player to Player 1'  
    end
  end
end
