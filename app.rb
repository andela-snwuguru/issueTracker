require 'sinatra'
require 'firebase'
require 'json'
require 'sanitize'
require 'sinatra/session'

set :session_fail, '/login'
set :session_secret, 'ATincketdIsseueTralckera'

require_relative 'firebase_util'

get '/' do
session!
  erb :index
end

get '/login' do
  if session?
    redirect '/'
  else
    @fb_root = FirebaseUtil.new

    #testing firebase storage
    @data = @fb_root.set 'department', {title: 'success',description: 'making sure we succeed'}
    
    'login here'
  end
end

get '/logout' do
  session_end!
  redirect '/'
end