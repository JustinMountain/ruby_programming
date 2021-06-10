def stock_picker(stocks)
  best_value = []
  best_value_diff = 0

  stocks.each_with_index do |value, index|
    compare = []
    buy_day = index

    until buy_day == stocks.length - 1
      tracker = 1
      until tracker + index == stocks.length
        compare[0] = stocks[index]
        compare[1] = stocks[index + tracker]
        diff = compare[1].to_i - compare[0].to_i

        if diff > best_value_diff
          best_value_diff = diff
          best_value[0] = index
          best_value[1] = index + tracker
        end
        tracker += 1
      end
      buy_day += 1
    end
  end
  puts "The best buy and sells days are represented by the indices #{best_value[0]} and #{best_value[1]}."
  puts "Buying and selling on these days represents a profit of $#{best_value_diff}."
end

stocks = [17,3,6,9,15,8,6,1,10]

stock_picker(stocks)