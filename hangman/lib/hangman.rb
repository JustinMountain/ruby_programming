require 'yaml'

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
  until guess.match(/^[[:alpha:]]+$/) && guess.length == 1 || guess.downcase.match("save")
    puts "Which letter would you like to guess?"
    guess = gets.chomp.downcase

    if guess.downcase.match("save")
      save_game($new_game)
      return "saved"
    end
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
    secret_word = choose_word(5, 12)
    hidden_word = hide_word(secret_word)  

    gets.chomp.upcase == "Y" ? new_game = Hangman.new(secret_word, hidden_word, 0) : return
  end
end

def save_game(hangman)
  yaml = YAML::dump(
    'secret_word' => secret_word,
    'hidden_word' => hidden_word,
    'guesses' => guesses
  )

  File.open("lib/saved.yaml", 'w') { |file| file.write yaml}
  puts "Game Saved!"
end

def load_game
  game_file = YAML.safe_load(File.open("lib/saved.yaml", 'r'))

  secret_word = game_file['secret_word']
  hidden_word = game_file['hidden_word']
  guesses = game_file['guesses']

  game = Hangman.new(secret_word, hidden_word, guesses)

end

class Hangman
  attr_accessor :secret_word, :hidden_word, :guesses

  def initialize(secret_word, hidden_word, guesses)
    @secret_word = secret_word
    @hidden_word = hidden_word
    @guesses = guesses.to_i

    puts "Your secret word has #{@secret_word.length} characters."
    puts "You can save your game at any time by typing 'save'."

    until @guesses == 8
      letter = grab_guess
      if letter == "saved"
        return
      end

      @secret_word.include?(letter) ? @hidden_word = replace_letters(letter, @secret_word, @hidden_word) : @guesses += 1
      draw_hangman(@guesses)
      draw_word(@hidden_word) 
      if @hidden_word.include?("_") == false
        @guesses = 8
      end 
    end
    @guesses == 8 ? play_again : return
  end
end

# Script on hangman.rb load
which_game = ""

until which_game.match("L") || which_game.match("N")
  puts "Would you like to load (L) a saved game or play a new (N) game?"
  which_game = gets.chomp.upcase
end

if which_game.match("L")
  load_game
elsif which_game.match("N")
  secret_word = choose_word(5, 12)
  hidden_word = hide_word(secret_word)

  $new_game = Hangman.new(secret_word, hidden_word, 0)
end