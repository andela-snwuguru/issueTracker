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
    erb :login
  end
end


get '/signup' do
  if session[:login]
    redirect '/'
  else
    erb :signup
  end
end


get '/recover' do
  if session[:login]
    redirect '/'
  else
    erb :recover
  end
end


get '/logout' do
  session_end!
  redirect '/'
end

post '/login' do
  if params[:email]
    session_start!
    session[:login] = true
    redirect '/'
  else
    redirect '/login'
  end
end