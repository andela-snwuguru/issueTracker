$(document).ready(function() {
  $("#menu").sideNav({edge: 'right'});
  $('select').material_select();

  $('#create_user').submit(function(evt){
    var form = evt.target
    var email = form.email.value
    var password = form.password.value
    var name = form.name.value
    var location = form.location.value
    var role = form.role.value
    var department = form.department.value

    if(Util.validateEmail(email)){
      Util.createUser(email,password,function(error,data){
        console.log(data)
      if(error){
        Util.alert(error,'red')
      }else{
        record = {
          email:email,
          name:name,
          location:location,
          role:role,
          department:department,
          action:'createUser'
        }
        Util.post('/api/post',record,function(data){
          result = jQuery.parseJSON(data);
          if(result.ok){
            document.location.href = '/users';
          }else{
            Util.alert('Unable to complete request','red');
            Util.removeUser(email,password,function(){});
          }
        })
      }
    });

    }else{
      Util.alert('Invalid Email formart','red')
    }
    return false;
  });


  $('#signup').submit(function(evt){
    var form = evt.target
    var email = form.email.value
    var password = form.password.value
    var confirm_password = form.confirm_password.value
    var name = form.name.value
    var location = form.location.value
    var role = 'Customer'
    if(password != confirm_password){
      Util.alert('Password mismatch!','red')
      return false
    }

    if(Util.validateEmail(email)){
      Util.createUser(email,password,function(error,data){
      if(error){
        Util.alert(error,'red')
      }else{
        record = {
          email:email,
          name:name,
          location:location,
          role:role,
          department:'none',
          action:'createUser',
          success:'Your account is created, use the login form'
        }
        Util.post('/api/post',record,function(data){
          result = jQuery.parseJSON(data);
          if(result.ok){
            document.location.href = '/dashboard';
          }else{
            Util.alert('Unable to complete request','red');
            Util.removeUser(email,password,function(){});
          }
        })
      }
    });

    }else{
      Util.alert('Invalid Email formart','red')
    }

    return false;
  });

  $('.delete_user').click(function(evt){
     var ref = $(this).attr('href')
     id = ref.replace('#/','')
     /*
        removing the user login will be implement here
        before the redirect
     */
     document.location.href = '/delete/user/'+id
    evt.preventDefault()
  });

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
      var userData = {
        uid: authData['uid'],
        email: email,
        action:'login'
      }

      Util.post('/api/post',userData,function(data){
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