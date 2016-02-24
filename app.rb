require 'sinatra'
require 'firebase'
require 'json'
require 'sanitize'
require 'sinatra/session'

set :session_fail, '/login'
set :session_secret, 'ATincketdIsseueTralckera'

require_relative 'src/authentication'

get '/' do
session!
  erb :index
end

get '/login' do
  if session?
    redirect '/'
  else
    'login here'
  end
end

get '/logout' do
  redirect '/'
end