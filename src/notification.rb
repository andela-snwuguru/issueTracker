module Guru
  class Notification

    def self.create record
      @fb = Guru::FirebaseUtil.new
      if @fb.push("notification",record)
        return true
      end
      false
    end

    def self.search key, value
      result = Notification.list
      result.select{|id,record| record[key] == value}
    end

    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch("notification/")
      result ? result : {}
    end

    def self.total session
      if Guru::Access.admin? session[:role]
        notifications = Notification.list
      elsif Guru::Access.customer? session[:role]
        notifications = Notification.search('uid',session[:uid])
      else
        notifications = Guru::Notification.search('department',session[:department])
      end
      notifications ? notifications.length : 0
    end


  end

end