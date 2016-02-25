module Guru
  class User

    def initialize
      @fb = Guru::FirebaseUtil.new
    end

    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch('users')
      result ? result : {}
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
      data.each{|key,value|
        if key != 'action' && key != 'id'
          if (key == 'department') && Guru::Access.customer?(data['role'])
            next
          end
          record[key] = value
        end
      }
      record
    end
  end

end