module ApiCallers
  class HttpRequest
    def initialize(uri, method = 'get')
      @in_uri = uri
      @method = method
    end

    def execute
    end
  end
end