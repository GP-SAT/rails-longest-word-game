require  "open-uri"

class GamesController < ApplicationController
  def new
    # letters = 10.times do 
    #   ('A'..'Z').to_a.shuffle.sample
    # end
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end
 
  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].split("")
    counter = 0
    @word.each do |letter|
      if @letters.include? letter
        counter += 1
      end
    end
    if @word.length == counter
      if english_word?(params[:word])
        @result = "Congratulations! #{@word} is a valid English word!"
      else
        @result = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
