require 'spec_helper'
require 'rspec-api/matchers/page_links/have_page_links'

describe 'have_page_links matcher' do
  include RSpecApi::Matchers::PageLinks
  let(:response) { OpenStruct.new headers: {} }

  describe 'expect(response).to have_page_links' do
    it 'passes if the response headers include the prev Link header' do
      response.headers = {'Link' => '<https://example.com/1>; rel="prev"'}
      expect(response).to have_page_links
    end

    it 'fails if the response headers does not include any Link header' do
      expect {
        expect(response).to have_page_links
      }.to fail_with %r{expected headers to include a 'Link' to the previous page, but got}
    end

    it 'fails if the response headers include a different Link header' do
      response.headers = {'Link' => '<https://example.com/3>; rel="next"'}
      expect {
        expect(response).to have_page_links
      }.to fail_with %r{expected headers to include a 'Link' to the previous page, but got}
    end
  end

  describe 'expect(response).not_to have_page_links' do
    it 'passes if the response headers do not include the prev Link header' do
      response.headers = {}
      expect(response).not_to have_page_links
    end

    it 'fails if the response headers include the given prev Link header' do
      response.headers = {'Link' => '<https://example.com/1>; rel="prev"'}
      expect {
        expect(response).not_to have_page_links
      }.to fail_with %r{expected headers not to include a 'Link' to the previous page, but got}
    end
  end
end