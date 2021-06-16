class PlayerSelect
  def self.maker
    input = ""
    until input == "1" || input == "2"
        puts "Do you want to break the code or make the code?"
        puts "Enter '1' to break the code or '2' to make the code:"    
        input = gets.chomp
    end
    input == "1" ? @maker = "computer" : @maker = "player"
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
    @results = ""

    # Check for equality at [i]
    i = 0
    while i < @code.length
      if @code[i] == @guess[i]
        # Add 1 correct "number in position" marker
        @results << "O"                                     # Symbol for correct number, correct position
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
      @results << "X"                                     # Symbol for correct number, wrong position
      j += 1
    end
  end

  def results
    string_return = "            Clues: " + @results + "\n"
    return string_return
  end

  def is_gameover
    @gameover = false
    @results == "OOOO" ? @gameover = true : @gameover = false
  end
end

class GamePlayLoop
  def initialize(maker)
    @attempt = 1

    if maker == "computer"
      code = CodeSelect.new(maker)
      send_code = Marshal.load(Marshal.dump(code))
      @guess = "0"
      p code.code

      while @attempt <= 12
        puts "What do you think the 4 digit password is?"
        @guess = gets.chomp

        until @guess.length == 4 && @guess.to_i > 0 && !@guess.include?("7") && !@guess.include?("8") && !@guess.include?("9") && !@guess.include?("0")
          puts "Don't forget the parameters of the code!"
          @guess = gets.chomp
        end

        #convert @guess from string to array
        @guess = @guess.split("")
        i = 0
        while i < 4
          @guess[i] = @guess[i].to_i
          i += 1
        end

        #create duplicate objects and find results for guess
        send_guess = Marshal.load(Marshal.dump(@guess))
        send_code = Marshal.load(Marshal.dump(code))
        results = CheckCode.new(send_code.code, send_guess)

        #print guess with results and increment attempt
        puts "\n"
        p @guess
        print results.results
        print "Guesses remaining: #{12 - @attempt} \n\n"

        if results.is_gameover
          p "You won in #{@attempt} guesses!"
          break
        end
        @attempt += 1
      end
    elsif maker == "player"
      # loop for computer as breaker
    end
  end
end

# # Check for player selection
# code_maker = PlayerSelect.new()
# puts "The #{code_maker.maker} will make the code."
# # Check for code creation
# code = CodeSelect.new(code_maker.maker)
# # p code.code

# Check for proper feedback
# CheckCode.new([1, 2, 3, 4], [1, 2, 3, 4])
# CheckCode.new(["1", "2", "3", "4"], ["1", "2", "3", "4"])
# CheckCode.new(["1", "2", "3", "4"], ["1", "2", "4", "3"])
# CheckCode.new(["1", "2", "3", "4"], ["4", "2", "3", "1"])

# Check for GamePlayLoop
game = GamePlayLoop.new(PlayerSelect.maker)

# Check win condition class
# is_finished = CheckWinCondition.new("OOOO")
# p is_finished.done