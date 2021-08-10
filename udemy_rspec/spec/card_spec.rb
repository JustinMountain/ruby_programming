class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

RSpec.describe Card do
  let(:test_card) { described_class.new('Ace', 'Spade') }

  it 'has a rank' do
    expect(test_card.rank).to eq('Ace')
    test_card.rank = 'Queen'
    expect(test_card.rank).to eq('Queen')
  end

  it 'has a suit' do
    expect(test_card.suit).to eq('Spade')
  end
end
