module Snapcat
  class MediaType
    IMAGE = 0
    VIDEO = 1
    VIDEO_NOAUDIO = 2
    FRIEND_REQUEST = 3
    FRIEND_REQUEST_IMAGE = 4
    FRIEND_REQUEST_VIDEO = 5
    FRIEND_REQUEST_VIDEO_NOAUDIO = 6

    def initialize(code)
      @code = code
    end

    def image?
      [IMAGE, FRIEND_REQUEST_IMAGE].include? @code
    end

    def file_extension
      if image?
        'jpg'
      elsif video?
        'mp4'
      end
    end

    def video?
      [
        VIDEO, VIDEO_NOAUDIO, FRIEND_REQUEST_VIDEO, FRIEND_REQUEST_VIDEO_NOAUDIO
      ].include? @code
    end
  end
end
