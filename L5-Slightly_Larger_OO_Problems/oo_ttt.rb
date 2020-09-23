# NEED TO IMPLEMENT
# keeping score - up to 5
# AI defense & offense + picking 5 if possible
# making fist player a choice
# allowing player to pick marker
# setting name for human and computer

module Displayable
  def clear
    system('cls')
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(array, punc = ', ', word = 'or')
    if array.count > 1
      last_element = array.delete(array.last)
      "#{array.join(punc)}#{punc}#{word} #{last_element}"
    else
      array[0]
    end
  end

  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe!"
    puts ""
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def display_board
    puts ""
    puts "You're an #{human.marker}. #{computer_name} is an #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def display_result
    clear
    display_board

    case determine_winner
    when TTTGame::HUMAN then puts "You won!"
    when TTTGame::COMPUTER then puts "#{computer_name} won!"
    else puts "It's a tie!"
    end
  end

  def display_scoreboard
    player = human.name.upcase
    computer = computer_name.upcase
    puts "#{player}: #{TTTGame::SCORES[0]} | #{computer}: #{TTTGame::SCORES[1]}"
  end

  def display_final_winner(winner)
    case winner
    when TTTGame::HUMAN then puts "Congratulations! You've won the tournament!"
    when TTTGame::COMPUTER then puts "#{computer_name} won the tournament!"
    end
  end

  def display_goodbye_message
    clear
    puts "Thanks for playing Tic-Tac-Toe, #{human.name}! Goodbye!"
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +  # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +  # columns
                  [[1, 5, 9], [3, 5, 7]]               # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "      |       |      "
    puts "  #{@squares[1]}   |   #{@squares[2]}   |   #{@squares[3]}"
    puts "      |       |      "
    puts "------+-------+-------"
    puts "      |       |      "
    puts "  #{@squares[4]}   |   #{@squares[5]}   |   #{@squares[6]}"
    puts "      |       |      "
    puts "------+-------+-------"
    puts "      |       |      "
    puts "  #{@squares[7]}   |   #{@squares[8]}   |   #{@squares[9]}"
    puts "      |       |      "
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def [](num)
    @squares[num].marker
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def strategic_move_available?
    !!nearly_winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def nearly_winning_marker
    nearly_winning_markers = []
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers_one_space?(squares)
        nearly_winning_markers << get_markers(squares).sort.join.strip[0]
      end
    end
    !nearly_winning_markers.empty? ? nearly_winning_markers.min : nil
  end

  def target_square(mark)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers_one_space?(squares)
        if squares.select(&:marked?).collect(&:marker).first == mark
          return line.select { |key| @squares[key].unmarked? }.first
        end
      end
    end
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_identical_markers_one_space?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end

  def get_markers(squares)
    markers = []
    squares.each do |square|
      markers << square.marker
    end
    markers
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :name, :marker

  def initialize(marker)
    @marker = marker
  end
end

class Human < Player
  def set_name
    puts "What's your name?"
    self.name = ''
    loop do
      self.name = gets.chomp
      break if name.match(/[A-Za-z]/)
      puts "Error: must input a name!"
    end
  end

  def set_marker
    puts "The computer's marker is O."
    puts "Please input a single character to use as your marker:"
    self.marker = ''
    loop do
      self.marker = gets.chomp
      break if marker.length == 1 && marker.match(/[^ O]/)
      puts "Error: Please input a single character that isn't O!"
    end
    marker
  end
end

class Computer < Player
  def ai_offense_or_defense(board, computer_marker, human_marker)
    case board.nearly_winning_marker
    when computer_marker then 'offense'
    when human_marker then 'defense'
    end
  end

  def ai_offense(board, marker)
    board.target_square(marker)
  end

  def ai_defense(board, marker)
    board.target_square(marker)
  end

  def select_random_square(board)
    (board.unmarked_keys).sample
  end
end

# Orchestration Engine
class TTTGame
  include Displayable

  COMPUTER_MARKER = 'O'
  HUMAN = 'human'
  COMPUTER = 'computer'
  SCORES = [0, 0] # [human wins, human losses]

  attr_reader :board, :human, :computer, :computer_name, :human_marker

  def initialize
    @board = Board.new
    @human = Human.new(Square::INITIAL_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @computer_name = ['R2D2', 'C3PO', 'Ava', 'Deep thought', 'HAL'].sample
  end

  def play
    clear
    display_welcome_message
    human.set_name
    clear
    @human_marker = human.set_marker
    clear
    main_game
    display_goodbye_message
  end

  private

  attr_writer :human_marker

  def main_game
    loop do
      SCORES[0] = 0 # resetting human win count
      SCORES[1] = 0 # resetting human loss count
      play_tournament
      pause
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def play_tournament
    loop do
      @current_marker = prompt_who_goes_first
      single_round
      break if winner?
    end
    determine_final_winner
  end

  def single_round
    clear
    display_board if @current_marker == human_marker
    player_move
    display_result
    keep_score
    pause_and_reset
  end

  def prompt_who_goes_first
    puts "Who's going first?"
    puts " 1 - I am!\n 2 - #{computer_name} can go first!\n 3 - You pick!"
    preference = ''
    loop do
      preference = gets.chomp
      break if ('1'..'3').include?(preference)
      puts "Error: Please input 1, 2, or 3!"
    end
    determine_who_goes_first(preference)
  end

  def determine_who_goes_first(preference)
    case preference
    when '1' then human_marker
    when '2' then COMPUTER_MARKER
    when '3' then [human_marker, COMPUTER_MARKER].sample
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def human_turn?
    @current_marker == human_marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = human_marker
    end
  end

  def human_moves
    puts "Choose a square: #{joinor(board.unmarked_keys)} "
    square = ''
    loop do
      square = gets.chomp.to_i
      break if (board.unmarked_keys).include?(square)
      puts "Error: That square isn't available!"
    end
    board[square] = human.marker
  end

  def computer_moves
    if board.unmarked_keys.include?(5)
      board[5] = computer.marker
    elsif board.strategic_move_available?
      strategic_computer_move
    else
      board[computer.select_random_square(board)] = computer.marker
    end
  end

  def strategic_computer_move
    case computer.ai_offense_or_defense(board, COMPUTER_MARKER, human_marker)
    when 'offense'
      board[computer.ai_offense(board, COMPUTER_MARKER)] = computer.marker
    when 'defense'
      board[computer.ai_defense(board, human_marker)] = computer.marker
    end
  end

  def determine_winner
    case board.winning_marker
    when human_marker then HUMAN
    when COMPUTER_MARKER then COMPUTER
    end
  end

  def keep_score
    determine_scores
    display_scoreboard
  end

  def determine_scores
    case determine_winner
    when HUMAN then SCORES[0] += 1
    when COMPUTER then SCORES[1] += 1
    end
  end

  def winner?
    SCORES[0] == 5 || SCORES[1] == 5
  end

  def determine_final_winner
    winner = SCORES[0] == 5 ? HUMAN : COMPUTER
    display_final_winner(winner)
  end

  def play_again?
    choice = ''
    loop do
      puts "Would you like to play again? (y/n)"
      choice = gets.chomp.downcase
      break if %w(y n).include? choice
      puts "Error: Please input 'y' or 'n'!"
    end
    choice == 'y'
  end

  def pause
    puts "Hit enter to continue!"
    gets.chomp
    clear
  end

  def pause_and_reset
    pause
    reset
  end

  def reset
    board.reset
    @current_marker = [human_marker, COMPUTER_MARKER]
    clear
  end
end

game = TTTGame.new
game.play
