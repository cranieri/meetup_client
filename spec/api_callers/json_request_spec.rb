require 'spec_helper'
require 'net/http'

describe ::ApiCallers::JsonRequest do
  subject { ::ApiCallers::JsonRequest.new('') }
  describe "#clean_response_body" do
    let(:body_response) { 'I\'m the \"Best\"' }

    it "removed \" from the passed text " do
      expect(subject.send(:clean_response_body, body_response)).to eq 'I\'m the Best'
    end

    it "forces the encoding to utf-8" do
      body_response.encode!('windows-1251')
      expect(subject.send(:clean_response_body, body_response).encoding.to_s).to eq 'UTF-8'
    end

  end

  describe "#headers" do
    it "returns { 'Accept-Charset' => 'utf-8' }" do
      expect(subject.send(:headers)).to eq({ 'Accept-Charset' => 'UTF-8' })
    end
  end

  describe "#class_to_call" do
    it "returns Net::HTTP::Get by default" do
      expect(subject.send(:class_to_call)).to eq Net::HTTP::Get
    end

    it "returns the class to call based on the request method, whether it is 'get', 'post', or 'delete'" do
      json_request = ::ApiCallers::JsonRequest.new('', 'post')
      expect(json_request.send(:class_to_call)).to eq Net::HTTP::Post
    end
  end
end
