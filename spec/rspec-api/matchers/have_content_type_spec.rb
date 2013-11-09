require 'spec_helper'
require 'rspec-api/matchers/content_type/have_content_type'

describe 'have_content_type matcher' do
  include RSpecApi::Matchers::ContentType
  let(:response) { OpenStruct.new headers: {} }

  describe 'expect(response).to have_content_type(...)' do
    it 'passes if the response headers include the given content type' do
      response.headers = {'Content-Type' => 'application/json; charset=utf-8'}
      expect(response).to have_content_type(:json)
    end

    it 'fails if the response headers include a different content type' do
      response.headers = {'Content-Type' => 'application/xml; charset=utf-8'}
      expect {
        expect(response).to have_content_type(:json)
      }.to fail_with %r{expected headers to include 'Content-Type': 'application/json; charset=utf-8', but got}
    end

    it 'passes if the response headers include any content type, given :any' do
      response.headers = {'Content-Type' => 'anything'}
      expect(response).to have_content_type(:any)
    end

    it 'fails if the response headers do not include any content type' do
      response.headers = {}
      expect {
        expect(response).to have_content_type(:any)
      }.to fail_with %r{expected headers to include 'Content-Type': '.+?', but got}
    end
  end

  describe 'expect(response).not_to have_content_type(...)' do
    it 'passes if the response headers do not include any content type' do
      response.status = 204
      expect(response).not_to have_content_type
    end

    it 'fails if the response headers include the given content type' do
      response.headers = {'Content-Type' => 'application/json; charset=utf-8'}
      expect {
        expect(response).not_to have_content_type(:json)
      }.to fail_with %r{expected headers not to include 'Content-Type': 'application/json; charset=utf-8', but got}
    end
  end
end