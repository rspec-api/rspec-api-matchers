require 'rspec-api/matchers/json'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response body is JSON. Optionally check if Array or Hash.
      # Skips if  if response body is JSON. Optionally check if Array or Hash.
      #
      # @example
      #
      #   # Passes if the body is valid JSON
      #   body = '{"id": 1}'
      #   expect(OpenStruct.new body: body).to be_valid_json
      #
      #   # Passes if the body is a valid JSON-marshalled Hash
      #   body = '{"id": 1}'
      #   expect(OpenStruct.new body: body).to be_valid_json(Hash)
      #
      #   # Passes if the body is a valid JSON-marshalled Array
      #   body = '[{"id": 1}, {"id": 2}]'
      #   expect(OpenStruct.new body: body).to be_valid_json(Array)
      def be_valid_json(type = nil)
        RSpecApi::Matchers::Json.new(type)
      end
    end
  end
end