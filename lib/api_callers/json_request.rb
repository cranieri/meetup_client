require 'api_callers/http_request'

module ApiCallers
  class JsonRequest < HttpRequest
    CHARSET = 'UTF-8'

    def execute
      uri = URI.parse(@in_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.request(class_to_call.new(uri.request_uri, headers))
      ActiveSupport::JSON.decode(clean_response_body(response.body))
    end

    private

    def clean_response_body(response_body)
      ActionController::Base.helpers.strip_tags(response_body.gsub('\"','').force_encoding(CHARSET))
    end

    def headers
      { 'Accept-Charset' => CHARSET }
    end

    def class_to_call
      "Net::HTTP::#{@method.capitalize}".constantize
    end
  end
end
