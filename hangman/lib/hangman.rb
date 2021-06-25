def choose_word(min, max)
  dictionary = []
  hidden_word = ""

  words = File.open("5desk.txt", "r")
  words.each do |word|
    dictionary << word.chomp
  end

  until hidden_word.length >= min && hidden_word.length <= max
    hidden_word = dictionary[rand(dictionary.length - 1)]
  end
  return hidden_word.downcase
end

def draw_hangman(wrong_guesses)
  # Top Section
  puts "    +---+"
  puts "    |   |"

  # Body
  if wrong_guesses == 8
    puts "    |   |"
    puts "    |   |"
    puts "    |   |"
    puts "    |   |"
  elsif wrong_guesses == 6 || wrong_guesses == 7
    puts "    |   O"
    puts "    |  /|\\ "
    puts "    |  / \\ "
    puts "    |"
  elsif wrong_guesses == 5
    puts "    |   O"
    puts "    |  /|\\ "
    puts "    |  /"
    puts "    |"
  elsif wrong_guesses == 4
    puts "    |   O"
    puts "    |  /|\\ "
    puts "    |"
    puts "    |"
  elsif wrong_guesses == 3
    puts "    |   O"
    puts "    |  /|"
    puts "    |"
    puts "    |"
  elsif wrong_guesses == 2
    puts "    |   O"
    puts "    |  /"
    puts "    |"
    puts "    |"
  elsif wrong_guesses == 1
    puts "    |   O"
    puts "    |"
    puts "    |"
    puts "    |"
  elsif wrong_guesses == 0
    puts "    |"
    puts "    |"
    puts "    |"
    puts "    |"
  end

  # Bottom
  if wrong_guesses == 8
    puts "  ===== | ="
    puts "        O"
    puts "       /|\\   You're all out of guesses..."
    puts "       / \\ "
  elsif wrong_guesses == 7
    puts "  =====   ="
    puts "  "
    puts "             Last chance..."
    puts "  "
  elsif wrong_guesses >= 0 && wrong_guesses < 7
    puts "  ========="
    puts "  "
    puts "             You have #{8 - wrong_guesses} guesses remaining:"
    puts "  "
  end
end

def draw_word(string)
  puts "             #{string}"
  puts ""
end

def grab_guess
  guess = ""
  until guess.match(/^[[:alpha:]]+$/) && guess.length == 1
    puts "Which letter would you like to guess?"
    guess = gets.chomp.downcase
  end
  return guess
end

def hide_word(secret_word)
  hidden_word = ""
  i = 0

  until i == secret_word.length
    hidden_word << "_ "
    i += 1
  end
  return hidden_word
end

def replace_letters(letter, secret_word, hidden_word)
  hidden_word = hidden_word.tr(" ", "")

  if hidden_word.length == secret_word.length
    i = 0
    until i == hidden_word.length
      if secret_word[i] == letter
        hidden_word[i] = letter
      end
      i += 1
    end
  else
    puts "Something has gone wrong"
  end

  revealed_word = ""
  hidden_word.each_char do |c|
    revealed_word << c + " "
  end
  return revealed_word
end

def play_again
  again = ""
  until again == "Y" || again == "N"
    puts "Do you want to play again? Y/n"
    gets.chomp.upcase == "Y" ? game_loop : return
  end
end

def game_loop
  secret_word = choose_word(5, 12)
  hidden_word = hide_word(secret_word)
  guesses = 0

  until guesses == 8
    letter = grab_guess
    secret_word.include?(letter) ? hidden_word = replace_letters(letter, secret_word, hidden_word) : guesses += 1
    draw_hangman(guesses)
    draw_word(hidden_word) 
    if hidden_word.include?("_") == false
      guesses = 8
    end 
  end
  guesses == 8 ? play_again : return
end

game_loop


