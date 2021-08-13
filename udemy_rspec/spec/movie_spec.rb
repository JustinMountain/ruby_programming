class Actor
  def initialize(name)
    @name = name
  end

  def ready?
    sleep(3)
    true
  end

  def act
    "I love you, baby"
  end

  def fall_off_ladder
    "Call my agent."
  end

  def light_on_fire
    false
  end
end

class Movie
  attr_reader :actor

  def initialize(actor)
    @actor = actor
  end

  def start_shooting
    if actor.ready?
      actor.act
      actor.fall_off_ladder
      actor.light_on_fire
      actor.act
    end
  end
end

# actor = Actor.new('Justin')
# movie = Movie.new(actor)
# movie.start_shooting

RSpec.describe Movie do
  let(:stuntman) { double('Dangerous', ready?: true, act: 'a string', fall_off_ladder: 'lets do it!', light_on_fire: true) }

  subject { described_class.new(stuntman) }

  describe '#start_shooting' do
    it 'expects an actor to do 3 actions' do
      # expect(stuntman).to receive(:ready?)
      # expect(stuntman).to receive(:act).exactly(2).times
      # expect(stuntman).to receive(:fall_off_ladder)
      # expect(stuntman).to receive(:light_on_fire)

      expect(stuntman).to receive(:light_on_fire).once
      expect(stuntman).to receive(:act).exactly(2).times

      subject.start_shooting
    end
  end
end
