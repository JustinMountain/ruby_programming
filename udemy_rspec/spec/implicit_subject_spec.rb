RSpec.describe Hash do
  it 'should start empty' do
    expect(subject.length).to eq(0)
    subject[:random_key] = "important value"
    expect(subject.length).to eq(1)
  end

  it 'is isolated between examples' do
    expect(subject.length).to eq(0)
  end
end
