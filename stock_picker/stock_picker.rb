stocks = [17,3,6,9,15,8,6,1,10]

def stock_picker(stocks)
  best_value = []

  # each_with_index
  stocks.each_with_index do |buy_value, buy_day|
    
    # p buy_day
    # p buy_value


    sell_day = buy_day
    
    unless sell_day == stocks.length 
      sell_day++
      sell_value = buy_value
      puts stocks[sell_day]
    end


    # p best_value
  end
  # at [i] multiply by each remaining element
  # take j - i, keeping whichever pair has the highest value
  # after completing, whichever is held is the best stocks
end

stock_picker(stocks)