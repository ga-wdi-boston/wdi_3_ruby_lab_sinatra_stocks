require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoo_finance'
require 'dotenv'
require 'twitter'

Dotenv.load

set :server, 'webrick'

def twitter_client
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["CONSUMER_KEY"]
	  config.consumer_secret     = ENV["CONSUMER_SECRET"]
	  config.access_token        = ENV["ACCESS_TOKEN"]
	  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
	end
end

get '/' do
  erb :quote
end

get '/quote/?:ticker?' do
	@ticker = params[:ticker]
	@data = YahooFinance.quotes([@ticker], [:volume, :last_trade_price, :high_52_weeks, :low_52_weeks]).first
	erb :quote
end

get '/twitter/:username' do
	@user = params[:username]
	@tweets = twitter_client.user_timeline(@user)
	erb :tweets
end

