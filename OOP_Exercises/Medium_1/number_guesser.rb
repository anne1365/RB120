class GuessingGame
  ZERO = 0
  MESSAGES = {
    high: "Your guess is too high!",
    low: "Your guess is too low!",
    match: "That's the number! You win!"
  }

  attr_reader :number, :guesses, :guess, :minimum, :maximum

  def initialize(minimum, maximum)
    @minimum = minimum
    @maximum = maximum
    new_game
  end

  def play
    clear
    new_game

    until guesses == ZERO
      output_number_remaining_guesses
      guess_number_prompt
      display_result
      return if guess == number
      decrement_guess_number
    end

    display_losing_message
  end

  private

  attr_writer :guesses, :guess

  def clear
    system("cls")
  end

  def new_game
    @number = (minimum..maximum).to_a.sample
    @guesses = Math.log2(size_of_range).to_i + 1
  end

  def size_of_range
    maximum - minimum
  end

  def output_number_remaining_guesses
    puts "You have #{guesses} guesses remaining."
  end

  def display_number_prompt
    print "Enter a number between #{minimum} and #{maximum}: "
  end

  def guess_number_prompt
    display_number_prompt

    self.guess = ''
    loop do
      self.guess = gets.chomp.to_i
      break if (minimum..maximum).cover?(guess)
      display_error_message
    end
  end

  def display_error_message
    print "Invalid guess. Enter a number between #{minimum} and #{maximum}: "
  end

  def display_result
    if guess == number
      puts MESSAGES[:match]
    elsif guess < number
      puts MESSAGES[:low]
    else
      puts MESSAGES[:high]
    end

    puts ""
  end

  def decrement_guess_number
    self.guesses -= 1
  end

  def display_losing_message
    puts "You lose! The number was #{number}!"
  end
end

game = GuessingGame.new(1, 10000)
game.play
gets.chomp
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!
