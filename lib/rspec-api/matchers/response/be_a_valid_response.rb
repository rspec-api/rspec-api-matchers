require 'rspec-api/matchers/response/matcher'

module RSpecApi
  module Matchers
    module Response
      # Passes if the object has either a status, headers or a body.
      #
      # @example Passes if the response has a status
      #   require 'rspec-api-matchers'
      #
      #   obj = OpenStruct.new status: 100
      #
      #   describe 'be_a_valid_response' do
      #     include RSpecApi::Matchers::Response
      #     it { expect(obj).to be_a_valid_response }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/dc2QFg be_a_valid_response_spec.rb for more examples
      def be_a_valid_response
        RSpecApi::Matchers::Response::Matcher.new
      end
    end
  end
end