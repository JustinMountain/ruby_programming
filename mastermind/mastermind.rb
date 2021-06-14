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
    @results = []

    # Check for equality at [i]
    i = 0
    while i < @code.length
      if @code[i] == @guess[i]
        # Add 1 correct "number in position" marker
        @results << "o"                                     # Symbol for correct number, correct position
        # Remove both from the array
        @code.delete_at(i)
        @guess.delete_at(i)
      else
        i += 1
      end
    end

    # Check for correct numbers
    diff = @code - @guess
    diff = @code - diff
    j = 0
    while j < diff.length
      @results << "x"                                     # Symbol for correct number, wrong position
      j += 1
    end
    p @results      
  end

  def results
    p @results
  end
end



# # Check for player selection
# code_maker = PlayerSelect.new()
# puts "The #{code_maker.maker} will make the code."
# # Check for code creation
# code = CodeSelect.new(code_maker.maker)
# # p code.code

CheckCode.new(["1", "2", "3", "4"], ["4", "3", "2", "1"])
CheckCode.new(["1", "2", "3", "4"], ["1", "2", "3", "4"])
CheckCode.new(["1", "2", "3", "4"], ["1", "2", "4", "3"])
CheckCode.new(["1", "2", "3", "4"], ["4", "2", "3", "1"])