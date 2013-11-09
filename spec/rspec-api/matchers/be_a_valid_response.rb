require 'spec_helper'
require 'rspec-api/matchers/response/be_a_valid_response'

describe 'be_a_valid_response matcher' do
  include RSpecApi::Matchers::Response

  describe 'expect(response).to be_a_valid_response' do
    it 'passes if the response has a status' do
      expect(OpenStruct.new status: :any).to be_a_valid_response
    end

    it 'passes if the response has headers' do
      expect(OpenStruct.new headers: :any).to be_a_valid_response
    end

    it 'passes if the response has a body' do
      expect(OpenStruct.new body: :any).to be_a_valid_response
    end

    it 'fails if the response does not have status, headers or body' do
      expect {
        expect(nil).to be_a_valid_response
      }.to fail_with %r{expected response to be a valid response, but got}
    end
  end

  describe 'expect(response).not_to be_a_valid_response' do
    it 'passes if the response does not have status, headers or body' do
      expect(OpenStruct.new something: :any).not_to be_a_valid_response
    end

    it 'fails if the response has a status' do
      expect {
        expect(OpenStruct.new status: :any).not_to be_a_valid_response
      }.to fail_with %r{expected response not to be a valid response, but got}
    end
  end
end