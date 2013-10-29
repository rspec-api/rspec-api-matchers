require 'spec_helper'

describe 'match_status matcher' do
  describe 'expect(...).to match_status(...)' do
    it 'passes if the expected code equals the actual code' do
      expect(200).to match_status(200)
    end

    it 'passes if the expected code is the symbol for the actual code' do
      expect(200).to match_status(:ok)
    end

    it 'fails if the expected code does not equal the actual code' do
      expect {
        expect(200).to match_status(404)
      }.to fail_with('expected 200 to be 404')
    end

    it 'fails if the expected code is not the symbol for the actual code' do
      expect {
        expect(200).to match_status(:not_found)
      }.to fail_with('expected 200 to be not_found')
    end

    it 'raises an error if the expected value is not a number or symbol' do
      expect {
        expect(200).to match_status('i am not a number or a symbol')
      }.to raise_error(ArgumentError, /must be a valid HTTP status code/)
    end

    it 'raises an error if the expected value is not an HTTP status code' do
      expect {
        expect(200).to match_status(999)
      }.to raise_error(ArgumentError, /must be a valid HTTP status code/)
    end

    it 'provides a description' do
      matcher = match_status(:ok)
      matcher.matches?(200)
      expect(matcher.description).to eq 'be ok'
    end
  end
end