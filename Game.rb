require_relative 'Word.rb'
require 'pry-byebug'
# Game class to play game.
class Game
  def initialize
    @word = Word.new
    p @word.chose_word
    p @split_words = @word.split_word
    @incorrect_guess = 0
    @length = @split_words.length
  end

  # To make array occurs dashes
  def make_dashes
    @guess_array = Array.new(@split_words.length, '_')
  end

  def print_dashes
    puts
    print @guess_array.join(' ')
    puts
    puts
  end

  def finished?
    if @guess_array.any?('_')
      false
    else
      true
    end
  end

  def check_already_entered(value)
    if @guess_array.include?(value)
      puts "#{value} is already included in the array!!!"
      true
    end
  end

  def check_guess(guess)
    if @split_words.include?(guess) && !check_already_entered(guess)
      @split_words.each_index do |i|
        @split_words[i] == guess && @guess_array[i] = guess
      end
    else
      @incorrect_guess += 1
      puts "You did #{@incorrect_guess} incorrect guess."
    end
  end

  def serialize
  File.open('game.yml','w') do |f| 
      YAML.dump([] << self, f) 
    end
    exit
  end

  # def load_game
  #   begin
  #     yaml = YAML.load_file("./game.yml")
  #     @history = yaml[0].history
  #   rescue
  #     @history = []
  #   end
  # end

  def take_guess
    puts 'Please enter a valid guess [a-z]'
    puts "You have #{@length} guess right"
    @guess = gets.chomp.downcase
    puts 'Write \'save\' if you want to save the game.'
    if @guess == 'save'
      serialize
    elsif @guess =~ /[^A-Za-z]/ # || @guess.length > 1
      puts 'It is invalid word. Try again.'
      puts
      take_guess
    end
  end

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
end

game = Game.new
game.guess
