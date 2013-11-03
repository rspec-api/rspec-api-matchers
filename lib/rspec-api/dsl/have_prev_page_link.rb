require 'rspec-api/matchers/prev_page_link'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response includes the pagination Link rel=prev in the headers
      #
      # @example
      #
      #   # Passes if the headers specify the pagination link for Prev
      #   headers = {'Link' => '<https://example.com/1>; rel="prev"'}
      #   expect(OpenStruct.new headers: headers).to have_prev_page_link
      def have_prev_page_link
        RSpecApi::Matchers::PrevPageLink.new
      end
    end
  end
end
