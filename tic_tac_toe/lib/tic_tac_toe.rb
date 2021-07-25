class GameSquare
  attr_accessor :content
  attr_accessor :is_playable

  def initialize(name)
    
    @name = name
    @content = " "
    @is_playable = true
  end

  def play(player)
    if is_playable == true 
      @is_playable = false
      if ($player == "Player1") 
        @content = "x"
      else 
        @content = "o"
      end
      player_changer()
    else
      puts "That square is already taken, please choose another."
    end
  end

  def player_changer
    $player == "Player1" ? ($player = "Player2") : ($player = "Player1")
    puts "Now it's #{$player}'s turn; please choose your coordinates."
  end
end

class GameBoard
  attr_accessor :top_left
  attr_accessor :top_middle
  attr_accessor :top_right
  attr_accessor :middle_left
  attr_accessor :middle_middle
  attr_accessor :middle_right
  attr_accessor :bottom_left
  attr_accessor :bottom_middle
  attr_accessor :bottom_right

  def initialize
    @top_left = GameSquare.new("1a")
    @top_middle = GameSquare.new("1b")
    @top_right = GameSquare.new("1c")
    @middle_left = GameSquare.new("2a")
    @middle_middle = GameSquare.new("2b")
    @middle_right = GameSquare.new("2c")
    @bottom_left = GameSquare.new("3a")
    @bottom_middle = GameSquare.new("3b")
    @bottom_right = GameSquare.new("3c")
    update_board()
  end

  def update_board
    print "         a   b   c \n"
    print "      1  #{@top_left.content} | #{@top_middle.content} | #{@top_right.content} \n"
    print "        ---|---|--- \n"
    print "      2  #{@middle_left.content} | #{@middle_middle.content} | #{@middle_right.content} \n"
    print "        ---|---|--- \n"
    print "      3  #{@bottom_left.content} | #{@bottom_middle.content} | #{@bottom_right.content} \n"
    check_winner()
  end

  def check_winner
    # Horizontal Win Conditions
    if (@top_left.content  == "x" && @top_middle.content  == "x" && @top_right.content == "x")
      declare_winner()
    elsif (@top_left.content  == "o" && @top_middle.content  == "o" && @top_right.content == "o")
      declare_winner()
    elsif (@middle_left.content  == "x" && @middle_middle.content  == "x" && @middle_right.content == "x")
      declare_winner()
    elsif (@middle_left.content  == "o" && @middle_middle.content  == "o" && @middle_right.content == "o")
      declare_winner()
    elsif (@bottom_left.content  == "x" && @bottom_middle.content  == "x" && @bottom_right.content == "x")
      declare_winner()
    elsif (@bottom_left.content  == "o" && @bottom_middle.content  == "o" && @bottom_right.content == "o")
      declare_winner()
    # Vertical Win Conditions
    elsif (@top_left.content  == "x" && @middle_left.content  == "x" && @bottom_left.content == "x")
      declare_winner()
    elsif (@top_left.content  == "o"&& @middle_left.content  == "o"&& @bottom_left.content == "o") == "o"
      declare_winner()
    elsif (@top_middle.content  == "x" && @middle_middle.content  == "x" && @bottom_middle.content == "x")
      declare_winner()
    elsif (@top_middle.content  == "o"&& @middle_middle.content  == "o"&& @bottom_middle.content == "o")
      declare_winner()
    elsif (@top_right.content  == "x" && @middle_right.content  == "x" && @bottom_right.content == "x")
      declare_winner()
    elsif (@top_right.content  == "o"&& @middle_right.content  == "o"&& @bottom_right.content == "o")
      declare_winner()
      declare_winner()
    # Diagonal Win Conditions
    elsif (@top_left.content  == "x" && @middle_middle.content  == "x" && @bottom_right.content == "x")
      declare_winner()
    elsif (@top_left.content  == "o"&& @middle_middle.content  == "o"&& @bottom_right.content == "o")
      declare_winner()
    elsif (@top_right.content  == "x" && @middle_middle.content  == "x" && @bottom_left.content == "x")
      declare_winner()
    elsif (@top_right.content  == "o"&& @middle_middle.content  == "o"&& @bottom_left.content == "o")
      declare_winner()
    end

    def declare_winner
      puts "#{$player} has won the game!"
      $no_winner = false
    end
  end
end

class GamePlayLoop
  attr_accessor :player
  attr_accessor :no_winner

  def initialize
    # Start of Game
    $no_winner = true
    $player = "Player1"

    retries = 2
    while retries >= 0
      puts "Would you like to play a game of Tic Tac Toe? (Y / N)"
      will_play = gets.chomp.upcase
      if will_play == "Y" || will_play == "YES"
        @board = GameBoard.new()
        PlayGame()
      elsif will_play == "N" || will_play == "NO"
        puts "That's too bad"
        $no_winner = false
      else 
        retries -= 1
      end
    end
    if retries < 0
      puts "No games for you, get back to work."
    end
  end

  def PlayGame
    puts "Please enter the coordinates where you'd like to play:"

    while $no_winner == true
      # Game Loop goes here
      play_square = gets.chomp
      if play_square == "1a"
        @board.top_left.play($player)
      elsif play_square == "1b"
        @board.top_middle.play($player)
      elsif play_square == "1c"
        @board.top_right.play($player)
      elsif play_square == "2a"
        @board.middle_left.play($player)
      elsif play_square == "2b"
        @board.middle_middle.play($player)
      elsif play_square == "2c"
        @board.middle_right.play($player)
      elsif play_square == "3a"
        @board.bottom_left.play($player)
      elsif play_square == "3b"
        @board.bottom_middle.play($player)
      elsif play_square == "3c"
        @board.bottom_right.play($player)
      else
        puts "There's no square at that coordinate"
      end
      @board.update_board
    end
    if $no_winner == false
      GamePlayLoop.new()
    end
  end
end

GamePlayLoop.new()

class 