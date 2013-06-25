require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/' do
  @ticker = params[:ticker]
  # YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTradereturn
  erb :quote
end

