require 'spec_helper'

describe 'be_valid_json matcher' do
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to be_valid_json(...)' do
    it 'passes if the response body is valid JSON' do
      response.body = '{"an":"object"}'
      expect(response).to be_valid_json
    end

    it 'passes if the response body matches the given type Hash' do
      response.body = '{"an":"object"}'
      expect(response).to be_valid_json(Hash)
    end

    it 'passes if the response body matches the given type Array' do
      response.body = '[{"an":"object"},{"another":"object"}]'
      expect(response).to be_valid_json(Array)
    end

    it 'passes if the response body (JSONP) matches the given type' do
      response.body = 'callback([{"an":"object"},{"another":"object"}])'
      expect(response).to be_valid_json(Array)
    end

    it 'fails if the response body does not match the given type' do
      response.body = '{"an":"object"}'
      expect {
        expect(response).to be_valid_json(Array)
      }.to fail_with %r{expected body to be a valid JSON Array, but got}
    end

    it 'fails if the response body is not a valid JSON' do
      response.body = 'not a valid json'
      expect {
        expect(response).to be_valid_json(Hash)
      }.to fail_with %r{expected body to be a valid JSON Hash, but got}
    end
  end

  describe 'expect(response).not_to be_valid_json(...)' do
    it 'passes if the response body does not match the given type' do
      response.body = '{"an":"object"}'
      expect(response).not_to be_valid_json(Array)
    end

    it 'fails if the response body matches the given type' do
      response.body = '{"an":"object"}'
      expect {
        expect(response).not_to be_valid_json(Hash)
      }.to fail_with %r{expected body not to be a valid JSON Hash, but it was}
    end
  end
end