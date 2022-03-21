require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (1..10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @word_array = @word.scan(/\w/)
    @letters_array = params[:letters].scan(/\w/)
    word_doable = @word_array.all? { |letter| @word_array.count(letter) <= @letters_array.count(letter) }
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word = JSON.parse(URI.open(url).read)
    exist = word['found']
    if word_doable == false
      @result = "Sorry but #{@word.upcase} can't be built out of #{@letters_array.join(', ').upcase}"
      @result
    elsif exist == false
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word.upcase} is a valide English word!"
    end
  end
end
