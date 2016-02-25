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

  class Access
    def self.admin? role
      role == Guru::Config::ADMIN_ROLE
    end

    def self.customer? role
      role == Guru::Config::CUSTOMER_ROLE
    end

    def self.customer_care? role
      role == Guru::Config::CUSTOMER__CARE_ROLE
    end
  end
end