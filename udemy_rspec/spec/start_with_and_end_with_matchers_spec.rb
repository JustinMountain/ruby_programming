RSpec.describe 'start_with and end_with matchers' do
  # these methods ARE case sensitive

  describe 'caterpillar' do
    it 'should check for a substring at the beginning' do
      expect(subject).to start_with('c')
      expect(subject).to start_with('cat')
      expect(subject).to start_with('cater')
    end

    it 'should check for a substring at the end' do
      expect(subject).to end_with('r')
      expect(subject).to end_with('ar')
      expect(subject).to end_with('llar')
    end

    it { is_expected.to start_with('cat')}
    it { is_expected.to end_with('ar')}
  end

  describe [1, 2, 3, 4, 5] do
    it 'should check for elements at the beginning or end of an array' do
      expect(subject).to start_with(1)
      expect(subject).to end_with(5)
    end

    it { is_expected.to start_with(1) }
    it { is_expected.to end_with(5) }
  end
end
