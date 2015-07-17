require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/' do
  @ticker = params[:ticker]
  unless @ticker.nil?
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker.upcase)[@ticker.upcase].lastTrade
  else
    @price = 0
  end

  erb :quote
end



