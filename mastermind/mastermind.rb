class PlayerSelect
  def initialize
    input = ""
    until input == "1" || input == "2"
        puts "Do you want to break the code or make the code?"
        puts "Enter '1' to break the code or '2' to make the code:"    
        input = gets.chomp
    end
    input == "1" ? @maker = "computer" : @maker = "player"
  end

  def maker
    @maker
  end
end

class CodeSelect
  def initialize(maker)
    @code = []
    if maker == "player"
      i = 0
      puts "You need to make a 4-digit code."
      while i <= 3 do
        if i == 0
          position = "first"
        elsif i == 1
          position = "second"
        elsif i == 3
          position = "third"
        elsif i == 3
          position = "fourth"
        end
        puts "Please enter the #{position} number between 1 and 6:"

        digit = gets.chomp.to_i
        if digit >= 1 && digit <= 6
          @code[i] = digit
          i += 1
        else
          puts "That wasn't a valid option."
        end
      end
      puts "Your secret passcode is #{@code}."

    elsif maker == "computer"
      i = 0
      while i <= 3 do
        @code[i] = 1 + Random.rand(6)
        i += 1
      end
    end
  end

  def code
    @code
  end
end

# Class to check the code and output proper feedback
class CheckCode
  def initialize(secret_code, guess)
    @code = secret_code
    @guess = guess
    #loop through guess[i], check for that value in code
      #if exists, check is it's at code[i]
        #add mark to results depending on the answer
  end
end

# Check for player selection
code_maker = PlayerSelect.new()
puts "The #{code_maker.maker} will make the code."
# Check for code creation
code = CodeSelect.new(code_maker.maker)
# p code.code