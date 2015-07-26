require 'spec_helper'
require 'net/http'

describe ::ApiCallers::JsonRequest do
  subject { ::ApiCallers::JsonRequest.new(response_body) }
  let(:response_body) do
    '{ "response": "I\'m the \"Best\"" }'
  end

  describe "#format_response" do
    let(:expected_json) do
      { "response" => 'I\'m the "Best"' }
    end

    it "formats the response from meetup" do
      expect(subject.format_response(response_body)).to eq expected_json
    end
  end
end
