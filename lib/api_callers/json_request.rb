require 'api_callers/http_request'
require 'json'

module ApiCallers
  class JsonRequest < HttpRequest
    def format_response(response_body)
      JSON.parse(response_body)
    end
  end
end
