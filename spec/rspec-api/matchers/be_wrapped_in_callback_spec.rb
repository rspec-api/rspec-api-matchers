require 'spec_helper'
require 'rspec-api/matchers/jsonp/be_wrapped_in_callback'

describe 'be_wrapped_in_callback matcher' do
  include RSpecApi::Matchers::Jsonp
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to be_wrapped_in_callback(...)' do
    it 'passes if the response body is wrapped in the given callback' do
      response.body = 'foo([{"site":"http://www.example.com","flag":null}])'
      expect(response).to be_wrapped_in_callback(:foo)
    end

    it 'fails if the response body is not wrapped in a callback' do
      response.body = 'Just some text with no function'
      expect {
        expect(response).to be_wrapped_in_callback(:foo)
      }.to fail_with %r{expected body to be wrapped in a JSONP callback foo, but got}
    end

    it 'fails if the response body is wrapped in a different callback' do
      response.body = 'foo([{"site":"http://www.example.com","flag":null}])'
      expect {
        expect(response).to be_wrapped_in_callback(:bar)
      }.to fail_with %r{expected body to be wrapped in a JSONP callback bar, but got}
    end

    it 'fails if the unwrapped response body is not valid JSON' do
      response.body = 'foo([{"this", "is", "not", "json"}])'
      expect {
        expect(response).to be_wrapped_in_callback(:foo)
      }.to fail_with %r{expected body to be wrapped in a JSONP callback foo, but got}
    end
  end

  describe 'expect(response).not_to be_wrapped_in_callback(...)' do
    it 'passes if the response body is not wrapped in a callback' do
      response.body = 'Just some text with no function'
      expect(response).not_to be_wrapped_in_callback
    end

    it 'fails if the response body is wrapped in a callback' do
      response.body = 'foo([{"site":"http://www.example.com","flag":null}])'
      expect {
        expect(response).not_to be_wrapped_in_callback
      }.to fail_with %r{expected body not to be wrapped in a JSONP callback, but got}
    end
  end
end