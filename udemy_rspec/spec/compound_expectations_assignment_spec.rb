RSpec.describe 'firetruck' do
  it 'starts with fire and ends with truck' do
    expect(subject).to start_with('fire').and end_with('truck')
  end

  it { is_expected.to start_with('fire') and end_with('truck') }
end

RSpec.describe 20 do
  it 'is even and responds to the times methods' do
    expect(subject).to be_even.and respond_to(:times)
  end

  it { is_expected.to be_even and respond_to(:times) }
end

RSpec.describe [4, 8, 15, 16, 23, 42] do
  it 'includes 42 and starts with the values 4, 8, 15' do
    expect(subject).to include(42).and start_with(4, 8, 15)
  end

  it { is_expected.to include(42) and start_with(4, 8, 15) }
end
