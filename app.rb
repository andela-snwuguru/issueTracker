require 'sinatra'
require 'firebase'
require 'json'
require 'sanitize'
require 'sinatra/session'

set :session_fail, '/auth/login'
set :session_secret, 'ATincketdIsseueTralckera'

require_relative 'src/config'
require_relative 'helpers'
require_relative 'src/authentication'
require_relative 'src/material_html'
require_relative 'src/firebase_util'
require_relative 'src/department'
require_relative 'src/user'


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
  session[:login] = false 
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
    when 'createUser'
      #session_start!
      user = Guru::User.new
      if user.create(params)
        alert('user created successfully','green')
        return {ok: true}.to_json
      else
        return {ok: false}.to_json
      end
      break
    else
      return {'message'=>'Invalid request'}.to_json
  end
  
end

post '/user' do
  session!
  case params[:action]
    when 'create'
      alert("Correct","green")
      redirect '/users'
      break
    else
      alert("Unknown post request","red")
      redirect '/'
  end
end