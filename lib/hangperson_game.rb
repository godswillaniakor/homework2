class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses ||= ''
    @wrong_guesses ||= ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(guessedLetter)
    #raise ArgumentError if guessedLetter.empty?
    raise ArgumentError if guessedLetter =~ /\W/i or guessedLetter.nil? or guessedLetter.empty?
    #raise ArgumentError if guessedLetter.nil?
    guessedLetter.downcase!
    if @word.include? guessedLetter and !@guesses.include? guessedLetter
    
      @guesses << guessedLetter 
      return true
    elsif !@word.include? guessedLetter and !@wrong_guesses.include? guessedLetter
       @wrong_guesses << guessedLetter
       return true
    end
    return false if @guesses.include? guessedLetter
    return false if @wrong_guesses.include? guessedLetter  
       
  end 
  
  def word_with_guesses
    #word.gsub(/./){ |letter| guesses.include?(letter) ? letter : '-' }
    words = ''
    @word.split('').each do |c|
      if @guesses.include? c.downcase
        words << c
      else
        words << '-'
      end
      end
      words
  end
  
  def check_win_or_lose
    if !(word_with_guesses.include? '-')
      :win
    elsif @wrong_guesses.length > 6
      :lose
    else
      :play
    end
  end
end


