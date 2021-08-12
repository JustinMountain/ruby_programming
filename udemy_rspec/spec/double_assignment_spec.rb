RSpec.describe 'double assignment' do
  it 'can be used to stand in for objects with methods and return values' do
    db = double('Database Connection', connect: true, disconnect: 'Goodbye')

    expect(db.connect).to eq(true)
    expect(db.disconnect).to eq('Goodbye')
  end

  it 'has a second syntax' do
    fs = double('File System')
    allow(fs).to receive(:read).and_return('Romeo and Juliet')
    allow(fs).to receive(:write).and_return(false)

    expect(fs.read).to eq('Romeo and Juliet')
    expect(fs.write).to eq(false)
  end
end

# Hashes more explicitly written
RSpec.describe 'doubles' do
  it "tests the student's knowledge of the course's content" do
    db = double('Database Connection', {
      connect: true,
      disconnect: 'Goodbye'
    })

    expect(db.connect).to eql(true)
    expect(db.disconnect).to eql('Goodbye')
  end
end
