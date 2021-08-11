RSpec.describe 'shorthand syntax' do
  subject { 5 } 

  context 'using classic syntax' do
    it 'should equal 5' do
      expect(subject).to eq(5)
    end
  end

  context 'using one-liner syntax' do
    it { is_expected.to eq(5) }
  end
end
