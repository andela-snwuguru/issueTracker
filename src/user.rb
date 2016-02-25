module Guru
  class User

    def initialize
      @fb = Guru::FirebaseUtil.new
      @fields = [
        'name',
        'location',
        'department',
        'role',
        'email',
      ]
    end

    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch('users')
      result ? result : {}
    end

    def self.search(key,value)
      users = User.list
      users.select{|id,record| record[key] == value}
    end
    
    def create data
      record = get_data data
      if @fb.push('users',record)
        return true
      end
      false
    end

    def update id, data
      record = get_data data
      if @fb.set("users/#{id}",record)
        return true
      end
      false
    end

    def get id
      result = @fb.get("users",id)
      result ? result : {}
    end

    def delete id
      if @fb.delete("users/#{id}")
        return true
      end
      false
    end

    private
    
    def get_data data
      record = {}
      record['department'] = 'none'
      @fields.each{|key|
        if (key == 'department') && Guru::Access.customer?(data['role'])
          next
        end
        record[key] = data[key]
      }
      record
    end
  end

end