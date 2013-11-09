require 'rspec-api/matchers/response/matcher'

module RSpecApi
  module Matchers
    module Response
      # Passes if response is present
      #
      # @example
      #
      #   # Passes if the response has a status
      #   response = OpenStruct.new status: 100
      #   expect(response).to be_a_valid_response
      #
      # For more examples check +be_a_valid_response_spec.rb+.
      def be_a_valid_response
        RSpecApi::Matchers::Response::Matcher.new
      end
    end
  end
end