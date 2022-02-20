require_relative 'Word.rb'
require 'pry-byebug'
require 'json'
# Game class to play game.
class Game
  def initialize
    @word = Word.new
    p @word.chose_word
    p @split_words = @word.split_word
    @incorrect_guess = 0
    @length = @split_words.length
  end

  # To make array occurs dashes(_____)
  def make_dashes
    @guess_array = Array.new(@split_words.length, '_')
  end

  def print_dashes
    puts
    print @guess_array.join(' ') # (_ _ _ _ _)
    puts
    puts
  end

  def finished?
    if @guess_array.any?('_') # If array include any dash('_'), game hasn't finished yet
      false
    else
      true
    end
  end

  def check_already_entered(value) # Check if dublicate value entered
    if @guess_array.include?(value)
      puts "#{value} is already included in the array!!!"
      true
    end
  end

  def check_guess(guess) # Check if guess exist in @split_words array and not already entered.
    if @split_words.include?(guess) && !check_already_entered(guess)
      @split_words.each_index do |i|
        @split_words[i] == guess && @guess_array[i] = guess
      end
    else
      @incorrect_guess += 1
      puts "You did #{@incorrect_guess} incorrect guess."
    end
  end

  # TODO Complate, serialize deserialize  method and take them another module or class
  def serialize
    file = File.open('game.yml', 'w') do |f|
      YAML.dump(self, f)
    end
    file.close
    exit
  end

  def deserialize
    File.open('game.yml', 'r') do |f|
      p YAML.load(f)
    end
    # p file['word']
  end

  # This method takes input, If save written, save game and exit
  def take_guess
    puts 'Please enter a valid guess [a-z]'
    puts "You have #{@length} guess right"
    @guess = gets.chomp.downcase
    puts 'Write \'save\' if you want to save the game.'
    if @guess == 'save'
      serialize
    elsif @guess =~ /[^A-Za-z]/ || @guess.length > 1
      puts 'It is invalid word. Try again.'
      puts
      take_guess
    end
  end

  # Main algorithm to check our guess inputs.
  def guess
    make_dashes
    print_dashes
    counter = 0
    until counter == @split_words.length || finished? == true
      take_guess
      check_guess(@guess)
      counter += 1
      @length -= 1
      print_dashes
    end
  end

  # play method to play game.
  def play
    puts '1) New Game'
    puts '2) Load Game'
    game = gets.chomp.downcase.to_i

    case game
    when 1
      guess
    when 2
      deserialize
    else
      'Wrong choice'
    end
  end
end

game = Game.new
game.play
