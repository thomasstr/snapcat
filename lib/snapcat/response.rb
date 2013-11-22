module Snapcat
  class Response
    attr_reader :code, :data, :http_success

    def initialize(response, additional_fields = {})
      @data = formatted_result(response).merge(additional_fields)
      @code = response.code
      @http_success = response.success?
    end

    def auth_token
      @data[:auth_token]
    end

    def success?
      if !@data[:logged].nil?
        !!@data[:logged]
      else
        @http_success
      end
    end

    private

    def response_empty?(response)
      response.body.to_s.empty?
    end

    def formatted_result(response)
      if !response_empty?(response)
        if response.content_type == 'application/octet-stream'
          { media: Media.new(response.body) }
        elsif response.content_type == 'application/json'
          JSON.parse(response.body, symbolize_names: true)
        else
          {}
        end
      else
        {}
      end
    end
  end
end
