require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoo_finance'
require 'twitter'
require 'dotenv'
require 'pg'


Dotenv.load
set :server, 'webrick'

# Begin Helper Methods
def run_sql(sql)
# boiler plate
  db = PG.connect(dbname: 'address_book', host: 'localhost')
  result = db.exec(sql)
  db.close
  result
end

# DB app
get '/people' do
  @people = run_sql('SELECT * FROM people')
  erb :people
end

post '/people' do
  name, phone = params[:name], params[:phone]
  run_sql("INSERT INTO people (name, phone) VALUES ('#{name.capitalize}', '#{phone}')")
  redirect to '/people'
end

post '/people/delete' do
  name = params[:name]
  run_sql("DELETE FROM people WHERE name = '#{name.capitalize}'")
  redirect to '/people'
end

def twitter_client
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end
end

# End Helper Methods


# Root Directory aka Home Page

get '/' do
  code = '<h1>Welcome!</h1> <p>Choose /quotes or /twitter</p>'
  erb code
end

# Quotes App Yahoo Finance
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


# Twitter app using Twitter gem
get '/twitter/?:user?' do |user|
  twitter = twitter_client
  if user
    @user = user
    begin
      @tweets = twitter.user_timeline(user)
    rescue Exception => e
      @error = "There has been an error in your request: <br><span>#{e.message}</span>"
    end
  end
  @msg = 'Please select a valid twitter username.'
  erb :twitter
end


