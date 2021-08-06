# frozen_string_literal: true

require_relative '../lib/chessnode'

RSpec.describe ChessNode do
  describe '#reset_node' do
    let(:test_node) { described_class.new }

    it "should reset to store 'empty' in the piece variable" do
      piece_name = test_node.piece

      expect(piece_name).to eq('empty')
    end

    it "should reset to store ' ' in the marker variable" do
      piece_marker = test_node.marker

      expect(piece_marker).to eq("\u00B7")
    end
  end

  describe '#knight' do
    let(:test_node) { described_class.new }

    it "should store 'Knight' as the piece name" do
      test_node.knight('Player1')
      piece_name = test_node.piece

      expect(piece_name).to eq('Knight')
    end

    it 'should return a white knight piece for player1' do
      test_node.knight('Player1')
      node_marker = test_node.marker

      expect(node_marker).to eq("\u2658")
    end

    it 'should return a black knight piece for player2' do
      test_node.knight('Player2')
      node_marker = test_node.marker

      expect(node_marker).to eq("\u265E")
    end

    it 'should return an error string for any other player value' do
      error_condition = test_node.knight('Banana')
      error_message = 'Invalid input for updating node'

      expect(error_condition).to eq(error_message)
    end

    it 'should return the player in the owner variable' do
      player = 'Player1'
      test_node.knight(player)
      owner = test_node.owner

      expect(owner).to eq(player)
    end
  end

  describe '#pawn' do
    let(:test_node) { described_class.new }

    it "should store 'Pawn' as the piece name" do
      test_node.pawn('Player1')
      piece_name = test_node.piece

      expect(piece_name).to eq('Pawn')
    end

    it 'should return a white pawn piece for player1' do
      test_node.pawn('Player1')
      node_marker = test_node.marker

      expect(node_marker).to eq("\u2659")
    end

    it 'should return a black pawn piece for player2' do
      test_node.pawn('Player2')
      node_marker = test_node.marker

      expect(node_marker).to eq("\u265F")
    end

    it 'should return an error string for any other player value' do
      error_condition = test_node.pawn('Banana')
      error_message = 'Invalid input for updating node'

      expect(error_condition).to eq(error_message)
    end

    it 'should return the player in the owner variable' do
      player = 'Player1'
      test_node.pawn(player)
      owner = test_node.owner

      expect(owner).to eq(player)
    end
  end
end
