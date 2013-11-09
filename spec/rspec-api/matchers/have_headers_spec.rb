require 'spec_helper'
require 'rspec-api/matchers/headers/have_headers'

describe 'have_headers matcher' do
  include RSpecApi::Matchers::Headers
  let(:response) { OpenStruct.new }

  describe 'expect(response).to have_headers(...)' do
    it 'passes if the response has a non-empty headers Hash' do
      response.headers = {'Content-Length' => 12345}
      expect(response).to have_headers
    end

    it 'fails if the response has an empty headers Hash' do
      response.headers = {}
      expect {
        expect(response).to have_headers
      }.to fail_with %r{expected headers to be a non-empty Hash, but got}
    end

    it 'fails if the response has a non-Hash headers' do
      response.headers = 'not a hash'
      expect {
        expect(response).to have_headers
      }.to fail_with %r{expected headers to be a non-empty Hash, but got}
    end

    it 'fails if the response does not have headers' do
      response.headers = nil
      expect {
        expect(response).to have_headers
      }.to fail_with %r{expected headers to be a non-empty Hash, but got}
    end
  end

  describe 'expect(response).not_to have_headers(...)' do
    it 'passes if the response does not have headers' do
      response.status = nil
      expect(response).not_to have_headers
    end

    it 'fails if the response has a non-empty headers Hash' do
      response.headers = {'Content-Length' => 12345}
      expect {
        expect(response).not_to have_headers
      }.to fail_with %r{expected headers not to be a non-empty Hash, but got}
    end
  end
end