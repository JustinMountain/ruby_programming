def substring(input_string, dictionary)
  result = {}
  # make case insensitive
  downcase_string = input_string.downcase

  dictionary.each do |word|
    # search input for word
    if downcase_string.include?(word)
      # hash at key [word] should be equal to the number of times it is found in the string
      result[word] = downcase_string.scan(word).count
    end
  end
  p result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts "What would you like to search the dictionary for?"
search_string = gets.chomp
if search_string == ""
  search_string = "Howdy partner, sit down! How's it going?"
  puts search_string
end

substring(search_string, dictionary)