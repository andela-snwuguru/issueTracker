$(document).ready(function() {
  $("#menu").sideNav({edge: 'right'});
  $('select').material_select();
});

function login(){
  email = $('#email').val()
  password = $('#password').val()

  if(email.length == 0 || password.length == 0){
    Util.alert('Email or Password cannot be blank','red')
    return
  }

  if(!Util.validateEmail(email)){
    Util.alert('Invalid Email formart','red')
    return
  }

  Util.login(email,password,function(error, authData){
    if(error){
      Util.alert(error,'red')
    }else{
      Util.post('/api/post',{email:email,action:'login'},function(data){
        result = jQuery.parseJSON(data)
        if(result.login){
          document.location.href = '/dashboard'
        }else{
          Util.alert('Unable to complete login process','red')
        }
      })
    }
  })
  return false;
}