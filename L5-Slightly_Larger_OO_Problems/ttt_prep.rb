=begin
Description: tic tac toe is a two-player game played on a 3x3 grid. Each player
has their own symbol, typically an 'X' or 'O'. Gameplay involves filling in
squares of the grid in a turn-based manner until either X's or O's form a straight
line across the board - the first person to do this wins the round

Nouns: 
 - board
 - player

Verbs
 - mark (take a turn)
=end

class Board
  INITIAL_MARKER = " "

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @square[key].marker = marker
  end
  
  # def someone_won?(marker)
  #   WIN_CONDITIONS.any? do |win_condition|
  #     win_condition.all? do |square|
  #       get_square_at(square) == marker
  #     end
  #   end
  # end

  # def status
  #   @squares.values.map { |square| square.marker }
  # end
end

class Square
  attr_accessor :marker

  def initialize(marker)
    # maybe a status to keep track of whether the square is empty or has a mark, and if it's
    # marked, by whom?
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

#Orchestration Engine
class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new('X')
    @computer = Player.new('O')
  end
 
  #private

  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe!"
    puts ""
  end

  def display_board
    puts "      |       |      "
    puts "  #{board.get_square_at(1)}   |   #{board.get_square_at(2)}   |   #{board.get_square_at(3)}   "
    puts "      |       |      "
    puts "------+-------+-------"
    puts "      |       |      "
    puts "  #{board.get_square_at(4)}   |   #{board.get_square_at(5)}   |   #{board.get_square_at(6)}   "
    puts "      |       |      "
    puts "------+-------+-------"
    puts "      |       |      "
    puts "  #{board.get_square_at(7)}   |   #{board.get_square_at(8)}   |   #{board.get_square_at(9)}   "
    puts "      |       |      "
  end

  def human_moves
    puts "Choose a square between 1-9: "
    square = ''
    loop do
      square = gets.chomp.to_i
      break if (1..9).include?(square)
      puts "Error: Invalid choice!"
    end
    board.set_square_at(square, human.marker)

    # choices = []
    # board.status.each_with_index { |marker, index| choices << (index + 1) if marker == Board::INITIAL_MARKER }
    # puts "PICK A SQUARE: #{choices.join(', ')}"
    # choice = gets.chomp.to_i
    # board[key] = 

  end

  def computer_moves

  end

  def someone_won?

  end

  def board_full?
    board.status.all? { |marker| marker != Board::INITIAL_MARKER }
  end

  def display_result

  end

  def display_goodbye_message
    puts "Thanks for playing Tic-Tac-Toe! Goodbye!"
  end

  #public

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      display_board
      break
      break if someone_won? || board_full?

      computer_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
