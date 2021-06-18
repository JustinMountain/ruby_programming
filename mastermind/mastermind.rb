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

class CheckCode
  def self.results(secret_code, guess_code)
    @secret_code = secret_code
    @guess_code = guess_code
    @results = ""

    i = 0
    while i < @secret_code.length
      if @guess_code[i] == @secret_code[i]
        # Add 1 correct "number in position" marker
        @results << "O"                                     # Symbol for correct number, correct position
      elsif @secret_code[i] == @guess_code[0] || @guess_code[1] || @guess_code[2] || @guess_code[3]
        # Add 1 correct number in wrong position marker
        @results << "X"                                         # Symbol for correct number, wrong position
      end
      i += 1
    end
    return @results
  end
end

class DisplayResults
  def self.display(secret_code, guess)
    @code = Marshal.load(Marshal.dump(secret_code))
    @guess = Marshal.load(Marshal.dump(guess))
    @results = ""

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
      @results << "X"                                       # Symbol for correct number, wrong position
      j += 1
    end
    return @results
  end
end

class GamePlayLoop
  def initialize(maker)
    if maker == "computer"
      PlayerGuessLoop.loop(maker)
    elsif maker == "player"
      ComputerGuessLoop.loop(maker)
    end
  end
end

class ArrayOfPossibilities
  def self.create_array
    # Make my Array of Arrays
    array_of_possibilities = Array.new(4)
    i = 0
    array0 = 1
    array1 = 1
    array2 = 1
    array3 = 1
    
    until array0 > 6 
      until array1 > 6
        until array2 > 6
          until array3 > 6
            array_of_possibilities[i] = [array0, array1, array2, array3]
            i += 1
            array3 += 1
          end
          array3 = 1
          array2 +=1
        end
        array2 = 1
        array1 +=1
      end
      array1 = 1
      array0 +=1
    end
    return array_of_possibilities
  end
end

class PlayerGuessLoop
  def self.loop(maker)
    attempt = 1
    code = CodeSelect.new(maker)
    send_code = code.clone
    while attempt <= 12
      puts "What do you think the 4 digit password is?"
      @guess = PlayerValidGuess.valid
      #create duplicate objects and find results for guess
      send_guess = @guess
      send_code = code
      results = DisplayResults.display(send_code.code, send_guess)

      #print guess with results and increment attempt
      PrintResults.print(@guess, results, attempt)
      GameOverCheck.check(maker, results, attempt)
      attempt += 1
    end
  end
end

class PlayerValidGuess
  def self.valid
    guess = gets.chomp
    until guess.length == 4 && guess.to_i > 0 && !guess.include?("7") && !guess.include?("8") && !guess.include?("9") && !guess.include?("0")
      puts "Don't forget the parameters of the code!"
      guess = gets.chomp
    end
    #convert @guess from string to array
    guess = guess.split("")
    i = 0
    while i < 4
      guess[i] = guess[i].to_i
      i += 1
    end
    return guess
  end
end

class ComputerGuessLoop
  def self.loop(maker)
    attempt = 1
    code = CodeSelect.new(maker)
    array_of_possibilities = ArrayOfPossibilities.create_array()

    while attempt <= 12
      
      if attempt == 1
        @guess = [1, 1, 2, 2]
      else
        @guess = array_of_possibilities[0]
      end

      results = DisplayResults.display(code.code, @guess)
      PrintResults.print(@guess, results, attempt)
      
      # Check for Game Over
      GameOverCheck.check(maker, results, attempt) ? break :      
      results = CheckCode.results(code.code, @guess)

      i = array_of_possibilities.length - 1
      until i < 0
        # check code
        send_possibility = array_of_possibilities[i]
        possible_results = CheckCode.results(@guess, send_possibility)
        unless results == possible_results
          array_of_possibilities.delete_at(i)
        end
        i -= 1
      end
      attempt += 1
    end
  end
end

class PrintResults
  def self.print(guess, results, attempt)
    puts "\n"
    p guess
    puts "            Clues: " + results + "\n"
    puts "Guesses remaining: #{12 - attempt} \n\n"
  end
end

class GameOverCheck
  def self.check(maker, results, attempt)
    if results == "OOOO"
      if maker == "computer"
        puts "You figured out the code in #{attempt} guesses."
      elsif maker == "player"
        puts "The computer deciphered your code in #{attempt} guesses."
      end 
      return true
    else 
      return false
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
# puts CheckCode.new([1, 2, 3, 4], [5, 4, 6, 2]).results
# puts CheckCode.new([5, 4, 6, 2], [1, 2, 3, 4]).results
# puts CheckCode.new(["1", "2", "3", "4"], ["1", "2", "3", "4"]).results
# puts CheckCode.new(["1", "2", "3", "4"], ["1", "2", "4", "3"]).results
# puts CheckCode.new(["1", "2", "3", "4"], ["4", "2", "3", "1"]).results

# Check for GamePlayLoop
game = GamePlayLoop.new(PlayerSelect.maker)

# Check win condition class
# is_finished = CheckWinCondition.new("OOOO")
# p is_finished.done


# master_code = [1, 2, 3, 4]
# guess = [1, 1, 1, 4]

# send_master = Marshal.load(Marshal.dump(master_code))
# send_guess = Marshal.load(Marshal.dump(guess))


# possible_results = CheckCode.new(send_master, send_guess)

# send_master = Marshal.load(Marshal.dump(master_code))
# send_guess = Marshal.load(Marshal.dump(guess))

# results = CheckCode.new(send_guess, send_master)

# puts master_code
# puts guess

# puts possible_results.results
# puts results.results


# puts possible_results.results == results.results