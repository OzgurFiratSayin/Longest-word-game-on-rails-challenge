require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:guess];
    @letters = params[:letters];


    def included?(guess, letters)
        guess.chars.all? { |letter| guess&.count(letter) <= letters.count(letter) }
    end

    def english_word?(word)
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      return json['found']
    end

    def compute_score(guess)
      guess.length
    end

    if included?(@guess, @letters) === false
      @result = "Sorry but #{@guess} cannot be built out of #{@letters}"
    elsif english_word?(@guess) === false
      @result = "Sorry but #{@guess} does not seem to be an English word"
    else
      @result = "Congratulations #{@guess} is a valid English word and your score is #{compute_score(@guess)}"
    end
    return @letters;
  end
end
