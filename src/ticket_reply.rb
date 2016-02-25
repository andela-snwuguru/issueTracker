module Guru
  class TicketReply

    def initialize
      @fb = Guru::FirebaseUtil.new
    end

    def create ticket_id,comment
      record = {
        'comment' => comment
      }
      if @fb.push("ticket_reply/#{ticket_id}",record)
        return true
      end
      false
    end

    def delete id
      if @fb.delete("ticket_reply/#{id}")
        return true
      end
      false
    end

    def get id
      result = @fb.get("ticket_reply",id)
      result ? result : {}
    end

    def update id, data
      record = get_data data
      if @fb.set("ticket_reply/#{id}",record)
        return true
      end
      false
    end
    def self.list ticket_id
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch("ticket_reply/#{ticket_id}")
      result ? result : {}
    end

  end

end