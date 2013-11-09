require 'spec_helper'
require 'rspec-api/matchers/json/be_valid_json'

describe 'be_valid_json matcher' do
  include RSpecApi::Matchers::Json

  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to be_valid_json' do
    it 'passes if the response body is valid JSON' do
      response.body = '[{"an":"object"},{"another":"object"}]'
      expect(response).to be_valid_json
    end

    it 'passes if the response body is JSON wrapped in a JSONP callback' do
      response.body = 'callback([{"an":"object"},{"another":"object"}])'
      expect(response).to be_valid_json
    end

    it 'fails if the response is nil' do
      expect {
        expect(nil).to be_valid_json
      }.to fail_with %r{expected body to be valid JSON, but got}
    end

    it 'fails if the response body is not valid JSON' do
      response.body = '{"an":"object", "lonely key"}'
      expect {
        expect(response).to be_valid_json
      }.to fail_with %r{expected body to be valid JSON, but got}
    end
  end

  describe 'expect(response).not_to be_valid_json' do
    it 'passes if the response body is not valid JSON' do
      response.body = '{"an":"object", "lonely key"}'
      expect(response).not_to be_valid_json
    end

    it 'fails if the response body is valid JSON' do
      response.body = '[{"an":"object"},{"another":"object"}]'
      expect {
        expect(response).not_to be_valid_json
      }.to fail_with %r{expected body not to be valid JSON, but got}
    end
  end
end