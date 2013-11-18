module Snapcat
  class Response
    attr_reader :data

    def initialize(response)
      @data = formatted_result(response)
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
      !response.body || response.body.empty?
    end

    def formatted_result(response)
      if response_empty?(response) || response.content_type != 'application/json'
        {}
      elsif response.content_type == 'application/json'
        JSON.parse(response.body, { symbolize_names: true })
      end
    end
  end
end
