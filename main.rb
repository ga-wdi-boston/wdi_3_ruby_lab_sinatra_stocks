require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote' do
  @ticker = params[:ticker]
  if @ticker
    @quote = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  else
    @quote = nil
  end
  erb :quote
end

