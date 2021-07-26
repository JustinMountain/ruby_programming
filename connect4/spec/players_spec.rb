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
      players.update_name('player1', 'Justin')

      expect(players.player1).to eq('Justin')
    end

    it 'should update the name of player2 to Tamy' do
      players.update_name('player2', 'Tamy')

      expect(players.player2).to eq('Tamy')
    end
  end
end
