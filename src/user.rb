module Guru
  class User

    def self.list
      {
      
      }
    end

    def create data
      record = get_data data
      @fb = Guru::FirebaseUtil.new
      if @fb.push('users',record)
        return true
      end
      false
    end

    private
    
    def get_data data
      record = {}
      data.each{|key,value|
        if key != 'action'
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