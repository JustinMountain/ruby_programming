RSpec.describe 'all matcher' do
  it 'allows for aggregrate checks' do
    # [5, 7, 9].each do |val| 
    #   expect(val).to be_odd
    # end

    # Same as above
    expect([5, 7, 9]).to all(be_odd)

    # Can be used for any predicate matcher
    expect([2, 4, 6, 8]).to all(be_even)
    expect([[], []]).to all(be_empty)
    expect([0, 0]).to all(be_zero)
    expect([5, 7, 9]).to all(be > 4)
  end

  describe [5, 7, 9] do
    it { is_expected.to all(be_odd) }
    it { is_expected.to all(be < 10) }
  end
end
