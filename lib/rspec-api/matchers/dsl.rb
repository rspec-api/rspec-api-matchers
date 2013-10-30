module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response has the given HTTP status code.
      #
      # @example
      #
      #   # Passes if the status is 200 OK (passed as a symbol)
      #   expect(OpenStruct.new status: 200).to match_status :ok
      #
      #   # Passes if the status is 200 OK (passed as a number)
      #   expect(OpenStruct.new status: 200).to match_status 200
      def have_status(status)
        RSpecApi::Matchers::Status.new status
      end

      # Passes if response includes the given Content-Type JSON in the headers
      #
      # @example
      #
      #   # Passes if the headers specify that Content-Type is JSON
      #   headers ={'Content-Type' => 'application/json; charset=utf-8'}
      #   expect(OpenStruct.new headers: headers).to include_content_type(:json)
      def include_content_type(type = nil)
        content_type = case type
        when :json then 'application/json; charset=utf-8'
        end
        RSpecApi::Matchers::ContentType.new content_type
      end

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

require 'rspec/matchers'
module RSpec
  module Matchers
    # Make RSpecApi::Matchers::DSL methods available inside RSpec
    include ::RSpecApi::Matchers::DSL
  end
end