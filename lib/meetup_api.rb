require 'api_callers/json_request'
require 'api_callers/http_requester'

class MeetupApi
  DIRECT_BASE_URL = 'http://api.meetup.com'
  METHOD_BASE_URL = 'http://api.meetup.com/2/'

  def direct_request(request_type, method_uri, params)
    request(DIRECT_BASE_URL + method_uri, params, request_type)
  end

  def method_request(method, params)
    request(METHOD_BASE_URL + method.to_s, params)
  end

  def method_missing(method, *args, &block)
    if method =~ /^(get|post|put|patch|delete)$/
      self.direct_request(method, args[0], args[1])
    else
      self.method_request(method, args[0])
    end
  end

  private

  def request(url_base, params, request_type = :get)
    params = params.merge( { key: ::MeetupClient.config.api_key } )
    url = "#{url_base}?#{query_string(params)}"

    json_request = ApiCallers::JsonRequest.new(url, request_type)
    requester = ApiCallers::HttpRequester.new(json_request)
    requester.execute_request
  end

  def query_string(params)
    params.map { |k,v| "#{k}=#{v}" }.join("&")
  end
end
