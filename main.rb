require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/' do

  @ticker = params[:ticker]
  if @ticker == nil
    @price = 0
  else
    @ticker.upcase!
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @ticker)[@ticker].lastTrade
  end
  erb :quote

end