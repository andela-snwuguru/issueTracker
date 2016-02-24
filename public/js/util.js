var Config = {
  fireBaseUrl:'https://ticketissuetracker.firebaseio.com'
}

var Util = {
    createUser:function(email,password,callBack){
      if(email === undefined || password === undefined)
          return false;

      fb = new Firebase(Config.fireBaseUrl);
      fb.createUser({
          email: email,
          password: password
      },callBack);
  },
  changePassword:function(email,oldPassword,newPassword,callBack){
      if(email === undefined || oldPassword === undefined || newPassword === undefined)
          return false;

      fb = new Firebase(Config.fireBaseUrl);
      fb.changePassword({
          email: email,
          oldPassword: oldPassword,
          newPassword: newPassword
      },callBack);
  },
  removeUser:function(email,password,callBack){
      if(email === undefined || password === undefined)
          return false;

      fb = new Firebase(Config.fireBaseUrl);
      fb.removeUser({
          email: email,
          password: password
      },callBack);
  },
  resetPassword:function(email,callBack){
      if(email === undefined)
          return false;

      fb = new Firebase(Config.fireBaseUrl);
      fb.resetPassword({
          email:email
      },callBack);

  },
  login:function(email,password,callBack){
      if(email === undefined || password === undefined)
          return false;

      fb = new Firebase(Config.fireBaseUrl);
      fb.authWithPassword({
          "email": email,
          "password":password
      },callBack);
  },
  search:function(path,key,value,callBack){
      fb = new Firebase(Config.fireBaseUrl+path);
      fb.orderByChild(key).startAt(value).endAt(value).on("child_added",callBack);
      fb.off('child_added',function(){});
  },
  validateEmail:function (email) {
        var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        return re.test(email);
    },
  alert:function(msg,color,key){
        if(key === undefined)
        key = '.alert';

        $(key).text(msg);
        $(key).addClass(color)
        $(key).fadeIn('slow',function(){
            var t = setInterval(function(){
                $(key).fadeOut('slow',function(){
                    $(key).text('');
                });
                clearInterval(t);
            },2000);
        });
    },
    post:function(path,data,callBack){
      $.post( path, data).done(callBack);

    }
}