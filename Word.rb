class Word
  attr_reader :dictionary

  def file_reading
    words = File.open('google-10000-english-no-swears.txt', 'r')
    File.readlines(words).each do |line|
      line.chomp!
    end
  end

  def make_dictionary
    @dictionary = []
    @dictionary << file_reading
    @dictionary.flatten!
  end

  def chose_word
    make_dictionary
    @word = @dictionary.select { |word| word.length >= 5 && word.length <= 12 }.sample
  end

  def split_word
    @word.split('')
  end
end
