RSpec.describe 'before and after hooks' do
  before(:context) do
    puts 'Before Context'
  end

  after(:context) do
    puts 'After Context'
  end

  before(:example) do
    puts 'Before Example'
  end

  after(:example) do
    puts 'After Example'
  end

  it 'is just an example' do
    expect(5 * 2).to eq(10)
  end

  it 'is just another example' do
    expect(5 * 5).to eq(25)
  end
end
