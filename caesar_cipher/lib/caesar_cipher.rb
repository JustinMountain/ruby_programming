def caesar_cipher(input_string, num) 
  num > 0 ? num = num % 26 : num = (num*-1 % 26)*-1

  # check if string is a string, number is a number
  if input_string.is_a?(String) == true && num.is_a?(Integer) == true
    # loop over the string
    chars = input_string.split("")
    cipher_string = ""
    chars.each do |char|
      # move the character value by the number
      if char.ord >= 97 && char.ord <= 122
        new_value = char.ord - num
        # wrap z to a
        if new_value <= 97
          new_value += 26
        elsif new_value >= 122
          new_value -= 26
        end
        new_char = new_value.chr.chomp
        cipher_string << new_char
      elsif char.ord >= 65 && char.ord <= 90
        new_value = char.ord - num
        # wrap Z to Z
        if new_value <= 65
          new_value += 26
        elsif new_value >= 90
          new_value -= 26
        end
        new_char = new_value.chr.chomp
        cipher_string << new_char
      else 
        cipher_string << char.chomp
      end
    end
  elsif string.is_a?(String) == false
    p "that's no string!"
    return nil
  elsif num.is_a?(Integer) == false
    p "that's no int!"
  end
  puts "Here is your coded message: "
  puts cipher_string
  cipher_string
end

# puts "Please enter a string to cipher"
# user_input = gets
# puts "How many digits would you like to adjust by"
# user_value = gets.chomp.to_i
# until user_value > 0
#   puts "That wasn't a number, please try again: "
#   user_value = gets.chomp.to_i
# end

# caesar_cipher(user_input, user_value)