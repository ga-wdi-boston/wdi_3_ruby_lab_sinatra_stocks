require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote/:ticker' do
  @ticker = params[:ticker].upcase
  return YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade.to_s
  erb :quote
end
