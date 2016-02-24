require 'sinatra'
require 'firebase'
require 'json'
require 'sanitize'
require 'sinatra/session'

set :session_fail, '/login'
set :session_secret, 'ATincketdIsseueTralckera'

require_relative 'src/authentication'
require_relative 'src/material_html'

def get_view view
  @views = {
  'dashboard'=> :index,
  'department' => :department,
  'login' => :login,
  'signup' => :signup,
  'recover' => :recover,
  'error' => :error,
  'ticket' => :ticket,
  'new_ticket' => :new_ticket,
}
  @views.each{|key,value|  
    return @views[view] if key == view
  }
  :error
end

get '/:view' do
  session!
  view = get_view params[:view]
  erb view
  
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