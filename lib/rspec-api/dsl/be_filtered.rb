require 'rspec-api/matchers/filter'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response body is filtered by +options[:by]+ comparing with +options[:comparing_with]+
      #
      # @example
      #
      #   # Passes if the body only contains ID = 1
      #   body = '[{"id": 1}, {"id": 1}, {"id": 1}]'
      #   expect(OpenStruct.new body: body).to be_filtered(1, by: :id)
      #
      #   # Passes if the body only contains ID < 10
      #   body = '[{"id": 1}, {"id": 6}, {"id": 3}]'
      #   expect(OpenStruct.new body: body).to be_filtered(10, by: :id, comparing_with: :<)
      def be_filtered(value = nil, options = {})
        RSpecApi::Matchers::Filter.new value, options
      end
    end
  end
end