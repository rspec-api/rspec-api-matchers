require 'spec_helper'

describe 'include_content_type matcher' do
  let(:response) { OpenStruct.new headers: {} }

  describe 'expect(response).to include_content_type(...)' do
    it 'passes if the response headers include the given content type' do
      response.headers = {'Content-Type' => 'application/json; charset=utf-8'}
      expect(response).to include_content_type(:json)
    end

    it 'fails if the response headers include a different content type' do
      response.headers = {'Content-Type' => 'application/xml; charset=utf-8'}
      expect {
        expect(response).to include_content_type(:json)
      }.to fail_with %r{expected headers to include 'Content-Type': 'application/json; charset=utf-8', but got}
    end

  end

  describe 'expect(response).not_to include_content_type(...)' do
    it 'passes if the response headers do not include any content type' do
      response.status = 204
      expect(response).not_to include_content_type
    end

    it 'fails if the response headers include the given content type' do
      response.headers = {'Content-Type' => 'application/json; charset=utf-8'}
      expect {
        expect(response).not_to include_content_type(:json)
      }.to fail_with %r{expected headers not to include 'Content-Type': 'application/json; charset=utf-8', but got}
    end
  end
end