require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/' do
  erb :quote
end

get '/form' do
  @ticker = params[:ticker]
  @price = params[:price]
  erb :form
end



