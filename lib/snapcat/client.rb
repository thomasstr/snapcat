module Snapcat
  class Client
    include HTTParty

    APP_VERSION = '6.0.0'
    SECRET = 'iEk21fuwZApXlz93750dmW22pw389dPwOk'
    STATIC_TOKEN = 'm198sOkJEn37DjqZ32lpRu76xmw288xSQ9'
    HASH_PATTERN = '0001110111101110001111010101111011010001001110011000110001000110'

    base_uri 'https://feelinsonice-hrd.appspot.com/bq/'

    attr_reader :logged_in, :user

    def initialize(username)
      @auth_token = STATIC_TOKEN
      @user = User.new(self)
      @username = username
    end

    def self.success?(result)
      !!result[:logged]
    end

    def request(endpoint, data = {})
      response = self.class.post(
        "/#{endpoint}",
        { body: merge_defaults_with(data) }
      )

      if !response.success?
        raise Snapcat::Error, "Snapcat response was a failure: #{response.code}"
      elsif response.body.empty?
        result = {}
      else
        result = symbolize_keys(JSON.parse(response.body))
      end

      @auth_token = result[:auth_token] || @auth_token
      result
    end

    def request_events(events, data = {})
      result = request_with_username(
        'update_snaps',
        events: events,
        json: data
      )

      result.empty?
    end

    def request_media(snap_id)
      response = self.class.post(
        '/blob',
        { body: merge_defaults_with({ username: @username, id: snap_id }) }
      )

      if !response.success?
        raise Snapcat::Error, "Snapcat response was a failure: #{response.code}"
      end

      response.body
    end

    def request_with_username(endpoint, data= {})
      request(endpoint, data.merge({ username: @username }))
    end

    def username=(new_username)
      if @logged_in
        raise SnapError, 'You cannot change a username while logged out'
      else
        @username = new_username
      end
    end

    private

    def built_token(auth_token, timestamp)
      hash_a = Digest::SHA256.new << "#{SECRET}#{auth_token}"
      hash_b = Digest::SHA256.new << "#{timestamp}#{SECRET}"

      HASH_PATTERN.split(//).each_index.inject('') do |final_string, index|
        if HASH_PATTERN[index] == '1'
          final_string << hash_b.to_s[index].to_s
        else
          final_string << hash_a.to_s[index].to_s
        end
      end
    end

    def merge_defaults_with(data)
      now = Timestamp.micro

      data.merge!({
        req_token: built_token(@auth_token, now),
        timestamp: now,
        version: APP_VERSION
      })
    end

    def symbolize_keys(myhash)
      myhash.keys.each do |key|
        myhash[(key.to_sym rescue key) || key] = myhash.delete(key)
      end

      myhash
    end
  end
end
