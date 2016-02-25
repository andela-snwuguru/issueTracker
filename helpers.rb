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


def alert message, color
  session[:message] = message
  session[:color] = color
end