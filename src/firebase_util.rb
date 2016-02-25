module Guru
  class FirebaseUtil
    URL = "https://ticketissuetracker.firebaseio.com"

    def initialize url = ''
      url = url.length > 1 ? url : URL
      @fb_root = Firebase::Client.new(url)
    end

    def get_root
      @fb_root
    end

    def get path,id
      @fb_root.get("/#{path}/#{id}").body
    end

    def fetch path, params = ''
      @fb_root.get("/#{path}",params).body
    end

    def set path, data
      @fb_root.set("/#{path}", data)
    end

    def push path, data
      @fb_root.push("/#{path}", data)
    end

    def delete path
      @fb_root.delete("/#{path}")
    end

  end
end