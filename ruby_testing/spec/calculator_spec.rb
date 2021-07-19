require './lib/calculator'

describe Calculator do
  describe "#add" do
    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end
  describe "#subtract" do
    it "subtracts numbers from the first integer passed to it" do
      calculator = Calculator.new
      expect(calculator.subtract(7, 5, 2)).to eql(0)
    end
  end
  describe "#multiply" do
    it "returns the multiple of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 5, 7)).to eql(70)
    end
  end
  describe "#divide" do
    it "divides numbers from the first integer passed to it" do
      calculator = Calculator.new
      expect(calculator.divide(10, 2, 5)).to eql(1)
    end
  end
end