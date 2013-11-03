require 'rspec-api/matchers/jsonp'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response body is in JSONP format
      #
      # @note
      #
      # A JSONP should actually return application/javascript...
      #
      # @example
      #
      #   # Passes if the body is a JSON wrapped in a callback
      #   body = 'alert([{"website":"http://www.example.com","flag":null}])'
      #   expect(OpenStruct.new body: body).to be_a_jsonp(:alert)
      def be_a_jsonp(callback = nil)
        RSpecApi::Matchers::Jsonp.new(callback)
      end
    end
  end
end