module Guru
  class Notification

    def initialize
      @fb = Guru::FirebaseUtil.new
    end

    def create user,ticket
      record = {
        'comment' => "#{user[:name]} has replied your ticket (<a href='/view/ticket/#{ticket[:id]}'>#{ticket[:title]}</a>)",
        'uid' => user[:uid],
      }
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