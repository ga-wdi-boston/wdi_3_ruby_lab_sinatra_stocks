require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/' do
  redirect to('/fetch_stock')
end
get '/fetch_stock' do
  #name of the hash is always params[:___]
  @ticker = params[:ticker]
  if @ticker
    @market_value = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  else
    @market_value = nil
  end
    erb (:quote)
end
