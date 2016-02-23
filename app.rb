require 'sinatra'
require 'firebase'
require 'json'
require 'sanitize'
require 'sinatra/session'

set :session_fail, '/login'
set :session_secret, 'ATincketdIsseueTralckera'

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
  session_end!
  redirect '/'
end