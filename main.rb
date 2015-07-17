require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote' do
  # puts ":ticker" + params[:ticker].inspect
  @ticker = params[:ticker]
  @result = if @ticker
    @ticker = @ticker.upcase
    YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  end
  erb :quote
end
