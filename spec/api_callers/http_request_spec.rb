require 'spec_helper'
require 'net/http'

describe ::ApiCallers::HttpRequest do
  subject { ::ApiCallers::HttpRequest.new('some_uri', http_verb) }
  let(:http_verb) { 'get' }

  describe "#make_request" do
    let(:http_obj) { double('http', request: request) }
    let(:request) { double('request', body: { response: 'response'}) }
    let(:url) { double('url', request_uri: 'request_uri', host: 'host', port: 'port') }

    before do
      allow(URI).to receive(:parse).and_return(url)
      allow(Net::HTTP).to receive(:new).and_return(http_obj)
    end

    context 'get request' do
      it 'make a request to the provided url' do
        allow(Net::HTTP::Get).to receive(:new).with('request_uri', { 'Accept-Charset' => 'UTF-8' }).and_return(:get_request)
        expect(Net::HTTP).to receive(:new)
        expect(http_obj).to receive(:request).with(:get_request)
        subject.make_request
      end
    end

    context 'post request' do
      let(:http_verb) { 'post' }
      it 'make a request to the provided url' do
        allow(Net::HTTP::Post).to receive(:new).with('request_uri', { 'Accept-Charset' => 'UTF-8' }).and_return(:post_request)
        expect(Net::HTTP).to receive(:new)
        expect(http_obj).to receive(:request).with(:post_request)
        subject.make_request
      end
    end
  end
end
