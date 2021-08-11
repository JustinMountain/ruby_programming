class Royalty
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

RSpec.describe Royalty do
  subject { described_class.new('Justin') }
  let(:tamy) { described_class.new('Tamy') }

  it 'represents a person of royalty' do
    expect(subject.name).to eq('Justin')
    expect(tamy.name).to eq('Tamy')
  end
end
