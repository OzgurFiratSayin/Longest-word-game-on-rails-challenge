require 'open-uri'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)
  def new
    @letters = Array.new(4) { VOWELS.sample }
    @letters += Array.new(6) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @guess = params[:guess];
    @letters = params[:letters];
    @included = included?(@guess, @letters)
    @english_word = english_word?(@guess)
    @score = @guess.length
  end

  private

  def included?(guess, letters)
    guess = guess.chars.map(&:upcase)
    guess.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
