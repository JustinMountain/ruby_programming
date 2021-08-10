RSpec.describe 'nested hooks' do
  before(:context) do
    puts 'OUTER Before Context'
  end

  before(:example) do
    puts 'OUTER Before Example'
  end

  it 'does basic math' do
    expect(1 + 1).to eq(2)
  end

  context 'with condition A' do
    before(:context) do
      puts 'INNER Before Context'
    end

    before(:example) do
      puts 'INNER Before Example'
    end

    it 'does more basic math' do
      expect(1 * 1).to eq(1)
    end

    it 'does even more basic math' do
      expect(2 * 2).to eq(4)
    end
  end
end
