class MeetupApi
  BASE_URL = 'http://api.meetup.com/2/'

  def method_request(method, params)
    json_request = ApiCallers::JsonRequest.new("#{BASE_URL}#{method}?#{query_string(params.merge( { key: MeetupClient.config.api_key } ))}")
    requester = ApiCallers::HttpRequester.new(json_request)
    requester.execute_request
  end

  def method_missing(method, *args, &block)
    self.method_request(method, args[0])
  end

  private

  def query_string(params)
     params.map { |k,v| "#{k}=#{v}" }.join("&")
  end
end
