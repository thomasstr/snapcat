module Snapcat
  class Media
    attr_reader :data

    def initialize(data)
      @data = Crypt.decrypt(data)
    end

    def image?
      @data[0..1] == "\xFF\xD8".force_encoding('ASCII-8BIT')
    end

    def file_extension
      if image?
        'jpg'
      elsif video?
        'mp4'
      end
    end

    def valid?
      image? || video?
    end

    def video?
      @data[0..1] == "\x00\x00".force_encoding('ASCII-8BIT')
    end
  end
end
