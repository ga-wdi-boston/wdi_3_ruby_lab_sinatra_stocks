require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/' do
  @ticker=params[:ticker]
  if !@ticker.nil?
    @price =YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  else
    @price = 0
  end
  erb :quote
end

