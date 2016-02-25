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

get '/delete/:model/:id' do
  session!

  case params[:model]
  when 'user'
    user = Guru::User.new
    if user.delete(params[:id])
      alert('User delete!','green')
      redirect '/users'
    else
      alert('Unable to delete User','red')
      redirect '/users'
    end
    break
  else
      erb :error
  end
end


get '/update/:model/:id' do
  session!

  case params[:model]
  when 'user'
    user = Guru::User.new
    @record = user.get(params[:id])
    @record['id'] = params[:id]
    return erb :update_user
    break
  else
      erb :error
  end
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
        msg = params[:success] ? params[:success] : 'user created successfully'
        alert(msg,'green')
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
    when 'update'
      user = Guru::User.new
      if user.update(params[:id],params)
        alert('user updated successfully','green')
        redirect '/users'
      else
        alert('Unable to update user record','red')
        redirect '/users'
      end
      break
    else
      alert("Unknown post request","red")
      redirect '/'
  end
end