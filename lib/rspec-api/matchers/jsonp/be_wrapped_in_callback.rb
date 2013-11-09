require 'rspec-api/matchers/jsonp/matcher'

module RSpecApi
  module Matchers
    module Jsonp
      # Passes if response body is a valid JSON wrapped in a JSONP callback
      #
      # @example
      #
      #   # Passes if the body is wrapped in "alert"
      #   body = 'alert([{"id": 1}])'
      #   expect(OpenStruct.new body: body).to be_wrapped_in_callback(:alert)
      #
      # @note
      #
      # A JSONP should actually return application/javascript...
      #
      # For more examples check +be_wrapped_in_callback_spec.rb+.
      def be_wrapped_in_callback(callback = nil)
        RSpecApi::Matchers::Jsonp::Matcher.new callback
      end
    end
  end
end