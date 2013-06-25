require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote' do
  @ticker = params[:ticker].upcase

  erb :quote
end
