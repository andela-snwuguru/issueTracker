module Guru
  class Department

    def initialize
      @fb = Guru::FirebaseUtil.new
      @fields = [
        'name',
        'description',
      ]
    end

    def create data
      record = get_data data
      if @fb.push('department',record)
        return true
      end
      false
    end

    def delete id
      if @fb.delete("department/#{id}")
        return true
      end
      false
    end

    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch('department')
      result ? result : {}
    end

    def self.list_data
      result = self.list
      data = {}
      result.each{|id,records|
        data[records['name']] = records['name']
      }
      data
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