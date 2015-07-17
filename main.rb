require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/stock_quote' do
  @ticker = params[:ticker]
  if @ticker
    @result = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  end
  erb :quote
end

