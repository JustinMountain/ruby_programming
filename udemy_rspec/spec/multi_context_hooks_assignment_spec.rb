RSpec.describe 'multi context hooks' do
  before(:context) do
    puts 'K'
  end
 
  before(:example) do
    puts 'Z'
  end
 
  after(:example) do
    puts 'E'
  end
 
  it 'can multiply' do
    expect(3 * 7).to eq(21)
  end
 
  it 'can divide' do
    expect(40 / 8).to eq(5)
  end
 
  context 'with some criteria' do
    before(:context) do
      puts 'H'
    end
 
    before(:example) do
      puts 'B'
    end
 
    it 'can subtract' do
      expect(10 - 5).to eq(5)
    end
 
    context 'in this condition' do
      before(:example) do
        puts 'V'
      end
 
      it 'can add' do
        expect(8 + 6).to eq(14)
      end
    end
  end
end

# K, 

# Z, 3 * 7 = 21, E, 

# Z, 40 / 8 = 5, E

#   H, 

#   Z, B, 10 - 5 = 5, E

#     Z, B, V, 8 + 6 = 14, E