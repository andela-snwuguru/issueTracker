module Guru
  class TicketReply

    def initialize
      @fb = Guru::FirebaseUtil.new
    end

    def create user,ticket_id,comment
      record = {
        'comment' => comment,
        'user' => user[:user],
        'uid' => user[:uid],
      }
      if @fb.push("ticket_reply/#{ticket_id}",record)
        return true
      end
      false
    end

    def delete ticket_id,id
      if @fb.delete("ticket_reply/#{ticket_id}/#{id}")
        return true
      end
      false
    end

    def get id
      result = @fb.get("ticket_reply",id)
      result ? result : {}
    end

    def self.list ticket_id
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch("ticket_reply/#{ticket_id}")
      result ? result : {}
    end

  end

end