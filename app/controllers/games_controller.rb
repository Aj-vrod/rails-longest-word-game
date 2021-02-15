require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    @suggestion = params[:suggestion]
    @grid = params[:grid].split
    url = "https://wagon-dictionary.herokuapp.com/#{@suggestion}"
    @data = JSON.parse(open(url).read)
    @score =
      if @data['found']
        if grid_included?
          "Congratulations! #{@suggestion.upcase} is a valid English word"
        else
          "Sorry but #{@suggestion.upcase} does not seems to be a valid English word"

        end
      else
        "Sorry but #{@suggestion.upcase} can't be built out of #{@grid.join(', ')}"
      end
  end

  def grid_included?
    @suggestion.upcase.chars.all? { |letter| @suggestion.count(letter) <= @grid.count(letter) }
  end
end
