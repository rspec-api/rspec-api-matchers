require 'rspec-api/matchers/content_type'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
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
        RSpecApi::Matchers::ContentType.new(content_type)
      end
    end
  end
end