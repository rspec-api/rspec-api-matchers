require 'rspec-api/matchers/status/matcher'

module RSpecApi
  module Matchers
    module Status
      # Passes if the response has a status that matches +status+.
      #
      # @example
      #
      #   # Passes if the response status matches :ok
      #   status = :ok
      #   expect(OpenStruct.new status: status).to have_status 200
      #
      # @note
      #
      #   The full list of symbolic HTTP status codes is available at:
      #   http://git.io/YwpDnA#L542
      #
      # For more examples check +have_headers_spec.rb+.
      def have_status(status)
        RSpecApi::Matchers::Status::Matcher.new status
      end
    end
  end
end