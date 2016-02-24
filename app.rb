require 'sinatra'
require 'firebase'
require 'json'
require 'sanitize'
require 'sinatra/session'

set :session_fail, '/auth/login'
set :session_secret, 'ATincketdIsseueTralckera'

require_relative 'src/authentication'
require_relative 'src/material_html'

def get_view(view,path = 'auth')
  @views = {
    'guest'=>{
      'login' => :login,
      'signup' => :signup,
      'recover' => :recover,
      },
    'auth'=>{
      'dashboard'=> :index,
      'department' => :department,
      'ticket' => :ticket,
      'new_ticket' => :new_ticket,
      'notification' => :notification,
      'users' => :users,
      'new_user' => :new_user,
    }
  
}
  @views[path].each{|key,value|  
    return @views[path][view] if key == view
  }
  :error
end

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
  session_end!
  session[:login] =false 
  redirect '/login'
end

get '/auth/:view' do
  if session[:login]
    redirect '/dashboard'
  end

  view = get_view params[:view], "guest"
  erb view
end

post '/login' do
  if params[:email]
    session_start!
    session[:login] = true
    redirect '/dashboard'
  else
    redirect '/login'
  end
end