module Guru
  class Notification

    def self.create record
      @fb = Guru::FirebaseUtil.new
      if @fb.push("notification",record)
        return true
      end
      false
    end


    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch("notification/")
      result ? result : {}
    end

  end

end