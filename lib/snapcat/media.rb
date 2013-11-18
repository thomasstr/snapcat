module Snapcat
  class Media
    attr_reader :data

    def initialize(data)
      @data = Crypt.decrypt(data)
    end

    def image?
      @data[0..1] == "\xFF\xD8"
    end

    def valid?
      image? || video?
    end

    def video?
      @data[0..1] == "\x00\x00"
    end
  end
end
