require 'rspec-api/matchers/sort/matcher'

module RSpecApi
  module Matchers
    module Sort
      # Passes if the response body is a non-empty sorted JSON collection
      #
      # @example
      #
      #   # Passes if the body is sorted by descending IDs
      #   body = '[{"id": 3}, {"id": 2}, {"id": 1}]'
      #   expect(OpenStruct.new body: body).to be_sorted(by: :id, verse: :desc)
      #
      # For more examples check +be_sorted_spec.rb+.
      def be_sorted(options = {})
        RSpecApi::Matchers::Sort::Matcher.new options
      end
    end
  end
end