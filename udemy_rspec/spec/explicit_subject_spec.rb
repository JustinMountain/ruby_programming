RSpec.describe Hash do
  subject(:custom_name) do
  end

  it 'has two key-value pairs' do
    expect(subject.length).to eq(2)
    expect(custom_name.length).to eq(2)
  end

  describe 'a nested example' do
    it 'works as expected' do
      expect(subject.length).to eq(2)
      expect(custom_name.length).to eq(2)
    end
  end
end
