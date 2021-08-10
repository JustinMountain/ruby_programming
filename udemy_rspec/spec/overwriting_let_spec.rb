class ProgrammingLanguage
  attr_reader :name

  def initialize(name = 'Ruby')
    @name = name
  end
end

RSpec.describe ProgrammingLanguage do
  let(:test_language) { described_class.new('Python') }

  it 'should store the name of the language' do
    expect(test_language.name).to eq('Python')
  end

  context 'with no initialization argument' do
    let(:test_language) { described_class.new }
    it 'should default to Ruby' do
      expect(test_language.name).to eq('Ruby')
    end
  end

  it 'should still store Python as the language name' do
    expect(test_language.name).to eq('Python')
  end
end
