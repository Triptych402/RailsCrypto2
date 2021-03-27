class HomeController < ApplicationController
  def index
  	#require 'net/http'
  	#require 'json'

  	@url = 'https://api.coinone.co.kr/ticker/?currency=all&format=json'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@coins = JSON.parse(@response)
  	@my_coins = ["WRX", "TRU", "XLM", "BTC"]

  end
end
