require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoo_finance'
require 'twitter'
require 'dotenv'


Dotenv.load
set :server, 'webrick'

def twitter_client
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end
end

# In you application /twitter/:user_name

get '/twitter/:user' do |user|
  twitter = twitter_client
  tweets = twitter.user_timeline(user)
  @result = ''
  20.times { |x| @result << "<b>Tweet Number #{x+1}</b>:<br> <i>#{tweets[x].text}</i><br><br> " }
  erb :twitter
end

get '/' do
  code = '<h1>Welcome!</h1> <p>Choose /quotes or /twitter</p>'
end

get '/quotes' do
  ticker = params[:ticker]
  request = [:name, :last_trade_price]
  params.keys.map { |e| e != :ticker && params[e.to_sym] == 'on' ? request << e.to_sym : nil } if params.keys
  request.flatten!
  ticker = ticker.upcase if ticker
  if ticker
    data = YahooFinance.quotes([ticker], request )
    data.each do |stock|
      @name = stock.name
      @sym = stock.symbol
      @last = stock.last_trade_price.to_f.round(2)
      @close = stock.close.to_f.round(2)
      @open = stock.open.to_f.round(2)
      @volume = stock.volume
      @avg_daily_vol = stock.average_daily_volume
      @bid = stock.bid
      @mark_cap = stock.market_capitalization
      @exchange = stock.stock_exchange
    end
  else
    @name = '<span>Input a stock!</span>'
  end
  erb :quote
end
