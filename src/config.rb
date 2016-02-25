module Guru
  class Config
     ADMIN_ROLE = 'Admin'
     CUSTOMER_ROLE = 'Customer'
     CUSTOMER_CARE_ROLE = 'Customer Care'
     STATUS_PROGRESS = 'in-progress'
     STATUS_PENDING = 'open issue'
     STATUS_CLOSED = 'closed issue'
     
    def self.roles
      {
        ADMIN_ROLE=>ADMIN_ROLE,
        CUSTOMER_ROLE=>CUSTOMER_ROLE,
        CUSTOMER_CARE_ROLE=>CUSTOMER_CARE_ROLE,
      }
    end

    def self.status
      {
        STATUS_PENDING=>STATUS_PENDING,
        STATUS_PROGRESS=>STATUS_PROGRESS,
        STATUS_CLOSED=>STATUS_CLOSED,
      }
    end

    def self.priority
      {'Low'=>'Low','Medium'=>'Medium','High'=>'High'}
    end

  end

end