require 'spec_helper'
require 'rspec-api/matchers/status/have_status'

describe 'have_status matcher' do
  include RSpecApi::Matchers::Status
  let(:response) { OpenStruct.new  }

  describe 'expect(response).to have_status(...)' do
    it 'passes if the response has the given numeric status code' do
      response.status = 200
      expect(response).to have_status 200
    end

    it 'passes if the response has the given symbolic status code' do
      response.status = 200
      expect(response).to have_status :ok
    end

    it 'fails if the response has a different numeric status code' do
      response.status = 200
      expect {
        expect(response).to have_status 404
      }.to fail_with %r{expected status code to be 404, but got}
    end

    it 'fails if the response has a different symbolic status code' do
      response.status = 200
      expect {
        expect(response).to have_status :not_found
      }.to fail_with %r{expected status code to be 404, but got}
    end

    it 'fails if the response has a different status code' do
      response.status = 200
      expect {
        expect(response).to have_status 'not a status code'
      }.to fail_with %r{expected status code to be not a status code, but got}
    end

    it 'fails if the response does not have a status code' do
      response.status = nil
      expect {
        expect(response).to have_status :ok
      }.to fail_with %r{expected status code to be 200, but got}
    end
  end

  describe 'expect(response).not_to have_status(...)' do
    it 'passes if the response has a different status code' do
      response.status = 200
      expect(response).not_to have_status 404
    end

    it 'fails if the response has the given status code' do
      response.status = 200
      expect {
        expect(response).not_to have_status :ok
      }.to fail_with %r{expected status code not to be 200, but got}
    end
  end
end