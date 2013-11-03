require 'rspec-api/matchers/status'

module RSpecApi
  module Matchers
    module DSL
      # Passes if response has the given HTTP status code.
      #
      # @example
      #
      #   # Passes if the status is 200 OK (passed as a symbol)
      #   expect(OpenStruct.new status: 200).to match_status :ok
      #
      #   # Passes if the status is 200 OK (passed as a number)
      #   expect(OpenStruct.new status: 200).to match_status 200
      def have_status(status)
        RSpecApi::Matchers::Status.new status
      end
    end
  end
end