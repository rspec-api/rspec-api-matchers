require 'spec_helper'

describe 'have_status matcher' do
  let(:response) { OpenStruct.new status: 200 }

  describe 'expect(...).to have_status(...)' do
    it 'passes if the response has the given numeric status code' do
      expect(response).to have_status 200
    end

    it 'passes if the response has the given symbolic status code' do
      expect(response).to have_status :ok
    end

    it 'fails if the response has a different numeric status code' do
      expect {
        expect(response).to have_status 404
      }.to fail_with 'expected HTTP status code 404, got 200'
    end

    it 'fails if the response has a different symbolic status code' do
      expect {
        expect(response).to have_status :not_found
      }.to fail_with 'expected HTTP status code 404, got 200'
    end

    it 'raises an error if the status code is not a number or symbol' do
      expect {
        expect(response).to have_status 'i am not a number or a symbol'
      }.to raise_error ArgumentError, /must be a valid HTTP status code/
    end

    it 'raises an error if the status code is not in the HTTP codes range' do
      expect {
        expect(response).to have_status 999
      }.to raise_error ArgumentError, /must be a valid HTTP status code/
    end

    it 'provides a description' do
      matcher = have_status(:ok)
      matcher.matches?(response)
      expect(matcher.description).to eq 'be HTTP status code 200'
    end
  end

  describe 'expect(...).not_to have_status(...)' do
    it 'passes if the expected code does not equal the actual code' do
      expect(response).not_to have_status(404)
    end

    it 'fails if the expected code equals the actual code' do
      expect {
        expect(response).not_to have_status(200)
      }.to fail_with('expected HTTP status code not to be 200, but it was')
    end
  end
end