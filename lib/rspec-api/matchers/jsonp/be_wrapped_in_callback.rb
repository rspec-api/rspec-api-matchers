require 'rspec-api/matchers/jsonp/matcher'

module RSpecApi
  module Matchers
    module Jsonp
      # Passes if the object has a JSONP callback-wrapped body
      #
      # @param [Symbol or String] callback Name of the wrapping JSONP callback
      #
      # @example Passes if the body is wrapped in the function "alert"
      #   require 'rspec-api-matchers'
      #
      #   body = 'alert([{"id": 1}])'
      #   obj = OpenStruct.new body: body
      #
      #   describe 'be_wrapped_in_callback' do
      #     include RSpecApi::Matchers::Jsonp
      #     it { expect(obj).to be_wrapped_in_callback(:alert) }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/XLeIOg be_wrapped_in_callback_spec.rb for more examples
      def be_wrapped_in_callback(callback = nil)
        RSpecApi::Matchers::Jsonp::Matcher.new callback
      end
    end
  end
end