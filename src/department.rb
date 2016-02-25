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

    def self.list
      @fb = Guru::FirebaseUtil.new
      result = @fb.fetch('department')
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