require 'rspec-api/matchers/json/matcher'

module RSpecApi
  module Matchers
    module Json
      # Passes if response body is a valid JSON or callback-wrapped JSON
      #
      # @example
      #
      #   # Passes if the body is valid JSON
      #   body = '[{"id": 1}]'
      #   expect(OpenStruct.new body: body).to be_valid_json
      #
      # For more examples check +be_valid_json_spec.rb+.
      def be_valid_json
        RSpecApi::Matchers::Json::Matcher.new
      end
    end
  end
end