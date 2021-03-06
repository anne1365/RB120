class Score
  attr_accessor :score

  def initialize
    @score = 0
  end

  def increment
    @score += 1
  end
end

class Move
  VALUES = { 'r' => 'rock',
             'p' => 'paper',
             's' => 'scissors',
             'l' => 'lizard',
             'o' => 'spock' }

  VALUE_INTERACTIONS = { 'rock' => ['scissors', 'lizard'],
                         'paper' => ['spock', 'rock'],
                         'scissors' => ['paper', 'lizard'],
                         'lizard' => ['spock', 'paper'],
                         'spock' => ['rock', 'scissors'] }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    VALUE_INTERACTIONS[@value].include?(other_move.to_s)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :all_moves

  def initialize
    set_name
    @all_moves = []
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty? || !(n.match(/[A-Za-z]/))
      puts("Error: Invalid entry!")
    end

    self.name = n
  end

  def choose
    choice = ''
    loop do
      puts "\nCHOOSE:"
      puts " r - rock\n p - paper\n s - scissors\n l - lizard\n o - spock"
      choice = gets.chomp.downcase
      break if Move::VALUES.keys.include?(choice)
      puts("Error: That's not a valid choice!")
    end
    self.move = Move.new(Move::VALUES[choice])
    all_moves << move.to_s
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'C3PO', 'Hal', 'Chappie', 'Sonny'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.values.sample)
    all_moves << move.to_s
  end
end

class RPSGame
  def initialize
    system('clear') || system('cls')
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    @human_pts = Score.new
    @computer_pts = Score.new
  end

  private

  attr_accessor :human, :computer, :human_pts, :computer_pts

  def display_divider
    puts "--------------------------------------------------------"
  end

  def new_round
    @human_pts = Score.new
    @computer_pts = Score.new
    human.all_moves.clear
    computer.all_moves.clear
    clear_screen
  end

  def display_welcome_message
    puts("--------------------------------------------------------")
    puts("    Welcome to Rock, Paper, Scissors, Lizard, Spock!    ")
    puts('--------------------------------------------------------')
    puts "   >>> THE FIRST PLAYER TO 5 WILL RULE THE GALAXY <<<\n\n"
  end

  def make_choices
    human.choose
    computer.choose
  end

  def process_round_outcome
    display_moves
    identify_winner
    display_winner
    increment_score
    display_scoreboard
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}.\n\n"
  end

  def identify_winner
    @winner = if human_win?
                'human'
              elsif computer_win?
                'computer'
              else
                'tie'
              end
  end

  def human_win?
    human.move > computer.move
  end

  def computer_win?
    computer.move > human.move
  end

  def display_winner
    case @winner
    when 'human' then puts "YOU WON! :D"
    when 'computer' then puts "COMPUTER WON! :("
    else puts "IT'S A TIE!"
    end
  end

  def increment_score
    case @winner
    when 'human'
      human_pts.increment
    when 'computer'
      computer_pts.increment
    end
  end

  def display_scoreboard
    puts "\nYou have #{human_pts.score} points."
    puts "#{computer.name} has #{computer_pts.score} points."
    display_divider
  end

  def final_winner?
    (computer_pts.score >= 5) || (human_pts.score >= 5)
  end

  def human_final_winner?
    human_pts.score > computer_pts.score
  end

  def computer_final_winner?
    computer_pts.score > human_pts.score
  end

  def display_final_winner
    if human_final_winner?
      puts "HUMANITY PREVAILS - YOU'VE WON THE TOURNAMENT!"
    elsif computer_final_winner?
      puts "#{computer.name.upcase} HAS WON THE TOURNAMENT!"
    else
      puts "NO VICTORS TODAY - IT'S A TIE!"
    end

    display_divider
  end

  def display_all_moves
    puts "YOUR MOVES:"
    human.all_moves.each_with_index { |move, n| puts "#{n + 1}. #{move}" }
    puts "\n#{computer.name.upcase}'S MOVES:"
    computer.all_moves.each_with_index { |move, n| puts "#{n + 1}. #{move}" }
    display_divider
  end

  def display_goodbye_message
    puts "\nThanks for playing!"
    clear_screen
  end

  def clear_screen
    puts "Hit any key to continue."
    gets.chomp
    system('clear') || system('cls')
  end

  def play_again?
    answer = ''
    loop do
      print "\nWould you like to play again? (y/n): "
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts("Error: That's not a valid choice!")
    end
    answer.downcase == 'y'
  end

  public

  def play
    loop do
      loop do
        make_choices
        process_round_outcome
        break display_final_winner if final_winner?
      end

      display_all_moves
      play_again? == true ? new_round : break
    end

    display_goodbye_message
  end
end

RPSGame.new.play
