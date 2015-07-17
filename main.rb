require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote' do
  @ticker = params[:ticker]
  if @ticker.nil?
    @price = 0
  else
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  end
  erb :quote
end


