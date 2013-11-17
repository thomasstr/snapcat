module Snapcat
  class Media
    attr_reader :data

    def initialize(data)
      @data = Crypt.decrypt(data)
    end

    def image?
      @data.length > 1 && @data[0..2] == "\xFF\xD8"
    end

    def valid?
      image? || video?
    end

    def video?
      @data.length > 1 && @data[0..2] == "\x00\x00"
    end

    private

    module Type
      MEDIA_IMAGE = 0
      MEDIA_VIDEO = 1
      MEDIA_VIDEO_NOAUDIO = 2
      MEDIA_FRIEND_REQUEST = 3
      MEDIA_FRIEND_REQUEST_IMAGE = 4
      MEDIA_FRIEND_REQUEST_VIDEO = 5

      def initialize(code)
        @code = code
      end

      def file_extension
        case code
        when MEDIA_VIDEO, MEDIA_VIDEO_NOAUDIO, MEDIA_FRIEND_REQUEST_VIDEO
          'mp4'
        when MEDIA_IMAGE, MEDIA_FRIEND_REQUEST_IMAGE
          'jpg'
        end
      end
    end
  end
end
