require 'rspec-api/matchers/collection'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response body is a collection
      #
      # @example
      #
      #   # Passes if the body is a collection
      #   body = '[{"id": 1}]'
      #   expect(OpenStruct.new body: body).to be_a_collection
      #
      #   # Passes if the body is not a collection
      #   body = '{"id": 1}'
      #   expect(OpenStruct.new body: body).not_to be_a_collection
      def be_a_collection
        RSpecApi::Matchers::Collection.new
      end
    end
  end
end