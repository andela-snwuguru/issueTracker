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
require_relative 'src/notification'
require_relative 'src/ticket'
require_relative 'src/ticket_reply'
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

get '/view/:model/:id' do
  session!
  case params[:model]
  when 'ticket'
    ticket = Guru::Ticket.new
    @record = ticket.get(params[:id])
    @record['id'] = params[:id]
    return erb :view_ticket
    break
  else
    erb :error
  end
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

get '/reply/:ticket_id/:id' do
  session!
  reply = Guru::TicketReply.new
  if reply.delete(params[:ticket_id],params[:id])
    alert('Reply deleted!','green')
  else
    alert('Unable to delete Reply','red')
  end
  redirect "/view/ticket/#{params[:ticket_id]}"
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
      alert('Unable to deleted User','red')
      redirect '/users'
    end
    break

  when 'department'
    department = Guru::Department.new
    if department.delete(params[:id])
      alert('Department deleted!','green')
      redirect '/department'
    else
      alert('Unable to delete Department','red')
      redirect '/department'
    end
    break
  when 'ticket'
    ticket = Guru::Ticket.new
    if ticket.delete(params[:id])
      alert('Ticket deleted!','green')
      redirect '/ticket'
    else
      alert('Unable to delete Ticket','red')
      redirect '/ticket'
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

  when 'ticket'
    ticket = Guru::Ticket.new
    @record = ticket.get(params[:id])
    @record['status'] = Guru::Config::STATUS_CLOSED
    if ticket.update(params[:id],@record)
      alert('Ticket closed!','green')
    else
      alert('Unable to close Ticket','red')
    end
    redirect "/view/ticket/#{params[:id]}"
    break
  else
      erb :error
  end
end

post '/api/post' do
  case params[:action]
    when 'login'
      if params[:email]
        user = Guru::User.search('email',params[:email])
        if user.empty?
          return {login: false}.to_json
        end
        session_start!
        session[:login] = true
        session[:uid] = params[:uid]
        user.each{|id,data|
          data.each{|key, value|
            session[key] = value
          }
        }
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


post '/department' do
  session!

  department = Guru::Department.new
  if department.create(params)
    alert('Department successfully created','green')
    redirect '/department'
  else
    alert('Unable to create department','red')
    redirect '/users'
  end
  redirect '/department'
end

post '/ticket' do
  session!

  ticket = Guru::Ticket.new
  if ticket.create({uid: session[:uid], user: session[:name]},params)
    alert('Ticket successfully created','green')
    redirect '/ticket'
  else
    alert('Unable to create ticket','red')
    redirect '/ticket'
  end
  redirect '/ticket'
end

post '/reply' do
  session!
  ticket_reply = Guru::TicketReply.new
  if ticket_reply.create({uid: session[:uid],user:session[:name]},params[:ticket_id],params[:comment])
    ticket = Guru::Ticket.new
    @record = ticket.get(params[:ticket_id])
    @record['status'] = Guru::Config::STATUS_PROGRESS
    notification_record = {
      'comment' => "#{session[:name]} has replied your ticket (<a href='/view/ticket/#{params[:ticket_id]}'>#{@record['title']}</a>)",
      'uid' => @record['uid'],
    }
    ticket.update(params[:ticket_id],@record)
    Guru::Notification.create(notification_record)
    alert('Reply successfully sent','green')
  else
    alert('Unable to send reply','red')
  end
  redirect "/view/ticket/#{params[:ticket_id]}"
end