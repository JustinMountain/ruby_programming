require './lib/caesar_cipher'

describe "#caesar_cipher" do
  it "shifts a simple string by a declared integer" do
    expect(caesar_cipher("eeeee", 2)).to eql("ccccc")
  end

  it "will wrap from Z to A" do
    expect(caesar_cipher("zzzzz", -1)).to eql("aaaaa")
  end

  it "will wrap from Z to A" do
    expect(caesar_cipher("aaaaa", 1)).to eql("zzzzz")
  end

  it "will wrap with very large numbers" do
    expect(caesar_cipher("aaaaa", 100)).to eql("eeeee")
  end

  it "ignores punctuation" do
    expect(caesar_cipher("?!:,", 1)).to eql("?!:,")
  end

  it "handles multiple words" do
    expect(caesar_cipher("hello justin", 3)).to eql("ebiil grpqfk")
  end

  it "handles capital letters" do
    expect(caesar_cipher("Hello Justin", 3)).to eql("Ebiil Grpqfk")
  end
end