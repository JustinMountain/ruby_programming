class ProfessionalWrestler
  attr_reader :name, :finisher

  def initialize(name, finisher)
    @name = name
    @finisher = finisher
  end
end

RSpec.describe 'have attributes matcher' do
  describe ProfessionalWrestler.new('Rock', 'Slam') do
    it 'checks for object attribute and proper values' do
      expect(subject).to have_attributes(name: 'Rock')
      expect(subject).to have_attributes(name: 'Rock', finisher: 'Slam')
    end

    it { is_expected.to have_attributes(name: 'Rock')}
  end
end
