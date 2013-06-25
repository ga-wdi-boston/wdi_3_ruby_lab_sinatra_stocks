require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/get_price' do
  @ticker = params[:ticker]

  # nothing to load when the page first loads
  if @ticker
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  end

  erb :quote
end