module Guru
  class TicketReply

    def initialize
      @fb = Guru::FirebaseUtil.new
      @fields = Ticket.list_fields
    end

    def self.list_fields
      [
        'comment',
      ]
    end

    def create data
      record = get_data data
      if @fb.push('ticket_reply',record)
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
    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch('ticket_reply')
      result ? result : {}
    end

    private
    def get_data data
      record = {}
      @fields.each{|key|
        record[key] = data[key]
      }
      record
    end

  end

end