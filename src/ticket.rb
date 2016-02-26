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
        'user',
        'created_at',
        'uid',
      ]
    end

    def create user, data
      data['status'] = Guru::Config::STATUS_PENDING
      record = get_data data
      record['created_at'] = Time.new
      record['uid'] = user[:uid]
      record['user'] = user[:user]
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

    def self.search key, value
      result = Ticket.list
      result.select{|id,record| record[key] == value}
    end

    def self.searchMultiple key, value, key2,value2
      result = Ticket.list
      result.select{|id,record| record[key] == value && record[key2] == value2}
    end

    def self.total session
      if Guru::Access.admin? session[:role]
        tickets = Ticket.list
      elsif Guru::Access.customer? session[:role]
        tickets = Ticket.search('uid', session[:uid]) 
      else
        tickets = Ticket.search('department',session[:department])
      end
      tickets ? tickets.length : 0
    end

    def self.total_by_status session, status
      if Guru::Access.admin? session[:role]
        tickets = Ticket.search('status', status) 
      elsif Guru::Access.customer? session[:role]
        tickets = Ticket.searchMultiple('uid', session[:uid],'status', status) 
      else
        tickets = Ticket.searchMultiple('department',session[:department],'status', status)
      end
      tickets ? tickets.length : 0
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