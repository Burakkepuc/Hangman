require_relative 'Word.rb'

class Game
  def initialize
    @word = Word.new
    p @word.chose_word
    p @split_word = @word.split_word
  end

  #To make array occurs dashes
  def make_dashes
    @guess_array = Array.new(@split_word.length, "_")
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

    puts "Please enter a guess"
    @guess = gets.chomp.downcase

    if @split_word.include?(@guess)
      # @guess_array << @guess
      #p @guess_array
      @split_word.each do |el|
        puts @split_word.index(el)
      end
      # puts "include #{@split_word.index(@guess) }. index"
    end
  end
end

game = Game.new
game.guess
