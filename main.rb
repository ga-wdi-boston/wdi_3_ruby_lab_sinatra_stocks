require 'pry'
require 'yahoofinance'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  if params.empty?
    @stock = nil
  else
    @ticker = params[:stock_quote]
    @stock = YahooFinance::get_quotes(YahooFinance::StandardQuotes, @ticker)[@ticker].lastTrade
  end
  erb :quote

end

get '/about' do
  erb :about
end
