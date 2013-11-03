require 'spec_helper'

describe 'be_a_jsonp matcher' do
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to be_a_jsonp(...)' do
    it 'passes if the response body is wrapped in the given callback' do
      response.body = 'foo([{"site":"http://www.example.com","flag":null}])'
      expect(response).to be_a_jsonp(:foo)
    end

    it 'fails if the response body is not wrapped in a callback' do
      response.body = 'Just some text with no function'
      expect {
        expect(response).to be_a_jsonp(:foo)
      }.to fail_with %r{expected body to be wrapped in a JSONP callback foo, but got}
    end

    it 'fails if the response body is wrapped in a different callback' do
      response.body = 'foo([{"site":"http://www.example.com","flag":null}])'
      expect {
        expect(response).to be_a_jsonp(:bar)
      }.to fail_with %r{expected body to be wrapped in a JSONP callback bar, but got}
    end
  end

  describe 'expect(response).not_to be_a_jsonp(...)' do
    it 'passes if the response body is not wrapped in a callback' do
      response.body = 'Just some text with no function'
      expect(response).not_to be_a_jsonp
    end

    it 'fails if the response body is wrapped in a callback' do
      response.body = 'foo([{"site":"http://www.example.com","flag":null}])'
      expect {
        expect(response).not_to be_a_jsonp
      }.to fail_with %r{expected body not to be wrapped in a JSONP callback, but it was}
    end
  end
end