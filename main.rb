require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoo_finance'

get '/quote/?:ticker?' do
	@ticker = params[:ticker]
	@data = YahooFinance.quotes([@ticker], [:low_52_weeks, :high_52_weeks, :last_trade_price, :pe_ratio, :last_trade_time])
	@last_trade_price = @data[0].last_trade_price
	@low_52_weeks = @data[0].low_52_weeks
	@high_52_weeks = @data[0].high_52_weeks
	@pe_ratio = @data[0].pe_ratio
	@last_trade_time = @data[0].last_trade_time
  erb :quote
end

get '/' do
	@ticker = params[:quotes]
	@data = YahooFinance.quotes([@ticker], [:low_52_weeks, :high_52_weeks, :last_trade_price, :pe_ratio, :last_trade_time])
	@last_trade_price = @data[0].last_trade_price
	@low_52_weeks = @data[0].low_52_weeks
	@high_52_weeks = @data[0].high_52_weeks
	@pe_ratio = @data[0].pe_ratio
	@last_trade_time = @data[0].last_trade_time
  erb :quote
end
