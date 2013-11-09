require 'rspec-api/matchers/filter/matcher'

module RSpecApi
  module Matchers
    module Filter
      # Passes if the response body is a non-empty filtered JSON collection
      #
      # @example
      #
      #   # Passes if the body only contains objects with ID = 1
      #   body = '[{"id": 1}, {"id": 1}, {"id": 1}]'
      #   expect(OpenStruct.new body: body).to be_filtered by: :id, value: 1
      #
      # For more examples check +be_filtered_spec.rb+.
      def be_filtered(options = {})
        RSpecApi::Matchers::Filter::Matcher.new options
      end
    end
  end
end