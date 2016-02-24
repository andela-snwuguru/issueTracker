require_relative 'firebase_util'


module Guru
  class Authentication

    def initialize
      @fb_root = FirebaseUtil.new
    end

    def login_by_password email,password
      
    end

    def login_by_facebook

    end
  end

end