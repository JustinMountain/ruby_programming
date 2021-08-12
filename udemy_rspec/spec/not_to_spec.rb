RSpec.describe 'not_to method' do
  it 'checks that two values do not match' do
    expect(10).not_to eq(5)
    expect('Hello').not_to eq('World')
  end

  it 'checks for the inverse of a matcher' do
    expect(5).not_to eq(10)
    expect([1, 2, 3]).not_to equal([1, 2, 3])
    expect(10).not_to be_odd
    expect([1, 2, 3]).not_to be_empty
    expect(nil).not_to be_truthy

    expect('hello').not_to start_with('world')
    expect('hello').not_to end_with('world')

    expect(5).not_to respond_to(:length)

    expect([1, 2, 3]).not_to include(4)

    expect { 11 / 3 }.not_to raise_error
  end
end
