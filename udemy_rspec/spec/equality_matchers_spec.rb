RSpec.describe 'equality matchers' do
  let(:a) { 3 }
  let(:b) { 3.0 }

  describe 'eq matcher' do
    it 'tests for value and ignores type' do
      expect(a).to eq(3)
      expect(b).to eq(3.0)
      expect(a).to eq(b)
    end
  end

  describe 'eql matcher' do
    it 'tests for value and type' do
      expect(a).to eql(3)
      expect(b).to eql(3.0)
      expect(a).not_to eql(b)
    end
  end

  describe 'equal matcher' do
    let(:c) { [1, 2, 3] }
    let(:d) { [1, 2, 3] }
    let(:e) { c }

    it 'tests if two things are the same object in memory' do
      expect(c).to equal(e)
      expect(c).not_to equal(d)
    end
  end

  describe 'be matcher' do # Alias for the equal matcher
    let(:c) { [1, 2, 3] }
    let(:d) { [1, 2, 3] }
    let(:e) { c }

    it 'tests if two things are the same object in memory' do
      expect(c).to be(e)
      expect(c).not_to be(d)
    end
  end
end
