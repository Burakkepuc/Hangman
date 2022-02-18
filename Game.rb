require_relative 'Word.rb'

class Game
  def initialize
    @word = Word.new
    p @word.chose_word
    p @split_words = @word.split_words
  end

  #To make array occurs dashes
  def make_dashes
    @guess_array = Array.new(@split_words.length, "_")
    @guess_array = @guess_array.join(' ')
  end

  def print_dashes
    puts
    print @guess_array
    puts
    puts
  end

  def guess
    make_dashes
    print_dashes


    #TODO The index of each entered element will be find.
    puts "Please enter a guess"
    @guess = gets.chomp.downcase

    if @split_words.include?(@guess)

      @split_words.each_index { |index| puts "#{index} #{@split_words[index]}" }
      # @guess_array << @guess
      #p @guess_array
     # puts "include #{@split_word.index(@guess) }. index"
    end
  end
end

game = Game.new
game.guess
