# frozen_string_literal: true

require_relative '../lib/players'

RSpec.describe Players do
  describe '#initialize' do
    let(:players) { described_class.new }

    it 'should output O marker for Player 1' do
      expect(players.marker1).to eq('O')
    end

    it 'should output X marker for Player 2' do
      expect(players.marker2).to eq('X')
    end

    it 'should return Player 1 for name' do
      expect(players.player1).to eq('Player 1')
    end

    it 'should return Player 2 for name' do
      expect(players.player2).to eq('Player 2')
    end
  end

  describe '#update_marker' do
    let(:players) { described_class.new }

    it 'should update the marker for player 1 to Y' do
      players.update_marker('player1', 'Y')

      expect(players.marker1).to eq('Y')
    end

    it 'should not allow a marker larger than 1 character' do
      players.update_marker('player1', '99')

      expect(players.marker1).to eq('O')
    end
  end

  describe '#update_name' do
    let(:players) { described_class.new }

    it 'should update the name of player1 to Justin' do
      players.update_name('Player1', 'Justin')

      expect(players.player1).to eq('Justin')
    end

    it 'should update the name of player2 to Tamy' do
      players.update_name('Player2', 'Tamy')

      expect(players.player2).to eq('Tamy')
    end
  end

  describe '#update_active_player' do
    let(:players) { described_class.new }

    context 'before the game starts' do
      it 'should start as nil' do
        expect(players.active_player).to be_nil
      end  
    end

    context 'updating at the start of the game' do
      it 'should update from nil to Player 1' do 
        active_player = players.update_active_player
        expect(active_player).to eq('Player 1')
      end
    end

    context 'the active player is Player 1' do
      before do
        players.update_active_player
      end

      it 'should update from Player 1 to Player 2' do
        active_player = players.update_active_player
        expect(active_player).to eq('Player 2')
      end
    end

    context 'the active player is Player 2' do
      before do
        players.update_active_player
        players.update_active_player
      end

      it 'should update from Player 1 to Player 2' do
        active_player = players.update_active_player
        expect(active_player).to eq('Player 1')
      end
    end
  end
end
