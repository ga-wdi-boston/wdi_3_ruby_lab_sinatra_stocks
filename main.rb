require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/stock_lab' do
 @ticker = params[:ticker]
  if @ticker
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  else
    @price = nil
  end
  erb :quote
end
