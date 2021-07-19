class Calculator
  def add(*args)
    args.inject() { |total, num| total + num}
  end
  def subtract(*args)
    args.inject() { |total, num| total - num}
  end
  def multiply(*args)
    args.inject() { |total, num| total * num}
  end
  def divide(*args)
    args.inject() { |total, num| total / num}
  end
end