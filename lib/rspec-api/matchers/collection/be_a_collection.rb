require 'rspec-api/matchers/collection/matcher'

module RSpecApi
  module Matchers
    module Collection
      # Passes if the response body is a collection of JSON objects
      #
      # @example
      #
      #   # Passes if the body is a JSON array
      #   body = '[{"id": 1}]'
      #   expect(OpenStruct.new body: body).to be_a_collection
      #
      # For more examples check +be_a_collection_spec.rb+.
      def be_a_collection
        RSpecApi::Matchers::Collection::Matcher.new
      end
    end
  end
end