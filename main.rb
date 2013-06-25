require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote_form' do
	@ticker = params[:ticker]
	erb :quote
end
