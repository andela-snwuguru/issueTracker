module Guru
  class Ticket

    def initialize
      @fb = Guru::FirebaseUtil.new
      @fields = Ticket.list_fields
    end

    def self.list_fields
      [
        'title',
        'department',
        'priority',
        'description',
        'status',
      ]
    end

    def create data
      data['status'] = Guru::Config::STATUS_PENDING
      record = get_data data
      if @fb.push('ticket',record)
        return true
      end
      false
    end

    def delete id
      if @fb.delete("ticket/#{id}")
        return true
      end
      false
    end

    def get id
      result = @fb.get("ticket",id)
      result ? result : {}
    end

    def update id, data
      record = get_data data
      if @fb.set("ticket/#{id}",record)
        return true
      end
      false
    end
    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch('ticket')
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