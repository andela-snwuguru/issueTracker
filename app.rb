require 'sinatra'
require 'firebase'
require 'json'
require 'sanitize'
require 'sinatra/session'

set :session_fail, '/auth/login'
set :session_secret, 'ATincketdIsseueTralckera'

require_relative 'helpers'
require_relative 'src/material_html'


get '/' do
  session!
  erb :index
end

get '/:view' do
  session!
  view = get_view params[:view]
  erb view
end

get '/user/logout' do
  session[:login] =false 
  session_end!
  redirect '/login'
end

get '/auth/:view' do
  if session[:login]
    redirect '/dashboard'
  end

  view = get_view params[:view], "guest"
  erb view
end

post '/api/post' do
  case params[:action]
    when 'login'
      if params[:email]
        session_start!
        session[:login] = true
       return {login: true}.to_json
      else
        return {'message'=>'Invalid request'}.to_json
      end
      break
    else
      return {'message'=>'Invalid request'}.to_json
  end
  
end