require 'spec_helper'

describe 'be_a_collection matcher' do
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to be_a_collection' do
    it 'passes if the response body is a collection' do
      response.body = '[{"an":"object"},{"another":"object"}]'
      expect(response).to be_a_collection
    end

    it 'passes if the response body is not a collection' do
      response.body = '{"an":"object"}'
      expect {
        expect(response).to be_a_collection
      }.to fail_with %r{expected body to be a collection, but got}
    end

    it 'fails if the response body is not a valid JSON' do
      response.body = 'not a valid json'
      expect {
        expect(response).to be_a_collection
      }.to fail_with %r{expected body to be a collection, but got}
    end
  end

  describe 'expect(response).not_to be_a_collection' do
    it 'passes if the response body is not a collection' do
      response.body = '{"an":"object"}'
      expect(response).not_to be_a_collection
    end

    it 'passes if the response body is a collection' do
      response.body = '[{"an":"object"}]'
      expect {
        expect(response).not_to be_a_collection
      }.to fail_with %r{expected body not to be a collection, but got}
    end
  end
end