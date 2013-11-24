require 'rspec-api/matchers/status/matcher'

module RSpecApi
  module Matchers
    module Status
      # Passes if the object has a status that matches +status+.
      #
      # @param [Symbol or Integer] status The expected status code
      #
      # @example Passes if the response status matches :ok
      #   require 'rspec-api-matchers'
      #
      #   obj = OpenStruct.new status: 200
      #
      #   describe 'have_status' do
      #     include RSpecApi::Matchers::Status
      #     it { expect(obj).to have_status :ok }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/YwpDnA#L542 List of symbolic HTTP status codes
      #
      # @see http://git.io/Gvb-nQ have_headers_spec.rb for more examples
      def have_status(status)
        RSpecApi::Matchers::Status::Matcher.new status
      end
    end
  end
end