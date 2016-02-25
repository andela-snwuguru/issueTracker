module Guru
  class Config
     ADMIN_ROLE = 'Admin'
     CUSTOMER_ROLE = 'Customer'
     CUSTOMER__CARE_ROLE = 'Customer Care'
     
    def self.roles
      {
        ADMIN_ROLE=>ADMIN_ROLE,
        CUSTOMER_ROLE=>CUSTOMER_ROLE,
        CUSTOMER__CARE_ROLE=>CUSTOMER__CARE_ROLE,
      }
    end

  end

end