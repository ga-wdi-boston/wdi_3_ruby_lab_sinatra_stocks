require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoo_finance'

get '/' do
  erb :quote
end

get '/quote/?:ticker?' do
	@ticker = params[:ticker]
	@data = YahooFinance.quotes([@ticker], [:volume, :last_trade_price, :high_52_weeks, :low_52_weeks]).first
	erb :quote
end
