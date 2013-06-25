require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote' do
  @ticker = params[:ticker]
  if @ticker
    @ticker.upcase!
    @result = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  end
  erb :quote
end
