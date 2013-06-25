require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

# get '/' do
#   erb :quote
# end

get '/quote' do
  @ticker = params[:ticker]
if @ticker
  @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade.round(2)
  end
  erb :quote
end
