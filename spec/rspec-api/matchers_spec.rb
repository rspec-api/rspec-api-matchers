require 'spec_helper'
require 'rspec-api/matchers'

describe RSpecApi::Matchers do
  context 'example groups tagged as :rspec_api', :rspec_api do
    it 'have access to the matchers' do
      expect(respond_to? :have_attributes).to be_true
      expect(respond_to? :be_a_collection).to be_true
      expect(respond_to? :have_content_type).to be_true
      expect(respond_to? :be_filtered).to be_true
      expect(respond_to? :be_valid_json).to be_true
      expect(respond_to? :be_wrapped_in_callback).to be_true
      expect(respond_to? :have_page_links).to be_true
      expect(respond_to? :be_a_valid_response).to be_true
      expect(respond_to? :be_sorted).to be_true
      expect(respond_to? :have_status).to be_true
    end
  end

  context 'example groups that include RSpecApi::Matchers' do
    include RSpecApi::Matchers::Attributes
    it 'have access to the matchers' do
      expect(respond_to? :have_attributes).to be_true
    end
  end

  context 'other example groups' do
    it 'do not have access to the matchers' do
      expect(respond_to? :have_attributes).to be_false
    end
  end
end