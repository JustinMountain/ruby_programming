RSpec.shared_context 'common' do
  before do
    @foods = []

    def a_method
      5
    end
  end

  let(:some_variable) { [1, 2, 3] }
end

RSpec.describe 'an example group' do
  include_context 'common'

  it 'can use the @foods instance variable' do
    expect(@foods.length).to eq(0)
    @foods << 'Piiza'
    expect(@foods.length).to eq(1)
  end

  it 'will reuse the context blocks' do
    expect(@foods.length).to eq(0)
  end
end

RSpec.describe 'another example' do
  include_context 'common'

  it 'will use the same shared variables' do
    expect(some_variable.length).to eq(3)
  end
end
