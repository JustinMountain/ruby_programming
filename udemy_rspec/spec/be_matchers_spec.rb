RSpec.describe 'be matchers' do
  it 'can test for truthiness' do
    # Anything that isn't false or nil will be truthy
    expect(true).to be_truthy
    expect('hello world').to be_truthy
    expect([]).to be_truthy
  end

  it 'can test for falsiness' do
    expect(false).to be_falsy
    expect(nil).to be_falsy
  end

  it 'can test for nil' do
    expect(nil).to be_nil

    some_hash = { key: 5 }
    expect(some_hash[:nothing]).to be_nil
  end
end
