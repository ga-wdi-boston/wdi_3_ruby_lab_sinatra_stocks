require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoo_finance'



get '/' do
  ticker = params[:ticker]
  request = [:name, :last_trade_price]
  params.keys.map { |e| e != :ticker && params[e.to_sym] == 'on' ? request << e.to_sym : nil } if params.keys
  request.flatten!
  ticker = ticker.upcase if ticker
  data = YahooFinance.quotes([ticker], request )
  data.each do |stock|
    @name = stock.name
    @sym = stock.symbol
    @last = stock.last_trade_price.to_f.round(2)
    @close = stock.close.to_f.round(2)
    @open = stock.open.to_f.round(2)
    @volume = stock.volume
    @avg_daily_vol = stock.average_daily_volume
    @bid = stock.bid
    @mark_cap = stock.market_capitalization
    @float = stock.float_shares
    @exchange = stock.stock_exchange
  end
  erb :quote
end
