require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/get_price' do
  @ticker = params[:ticker].to_s
  erb :quote
end

