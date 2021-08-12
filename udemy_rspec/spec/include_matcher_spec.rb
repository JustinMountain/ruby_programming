RSpec.describe 'include matcher' do
  describe 'hot chocolate' do
    it 'checks for substring inclusion' do
      expect(subject).to include('hot')
      expect(subject).to include('choco')
      expect(subject).to include('late')
    end

    it { is_expected.to include('hot') }
  end

  describe [1, 2, 3, 4, 5] do
    it 'checks for inclusion in an array, regardless of order' do
      expect(subject).to include(1)
      expect(subject).to include(2, 3)
      expect(subject).to include(4, 5)
    end

    it { is_expected.to include(3) }
  end

  describe({ a: 2, b: 4 }) do
    it 'can check for key existence' do
      expect(subject).to include(:a)
      expect(subject).to include(:a, :b)
    end

    it 'can check for a key-value pair' do
      expect(subject).to include(a: 2)
    end

    it { is_expected.to include(a: 2, b: 4) }
  end
end
