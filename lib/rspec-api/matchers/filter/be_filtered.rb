require 'rspec-api/matchers/filter/matcher'

module RSpecApi
  module Matchers
    module Filter
      # Passes if the object has a non-empty filtered JSON collection in the body.
      #
      # @param [Hash] options how the body is expected to be filtered.
      # @option options [Symbol or String] :by The JSON key to be filtered by
      # @option options [Object] :value The expected value for the field
      # @option options [Proc or Symbol] :compare_with (:==) The operator used
      #   to compare the expected value with the values in the collection
      #
      # @example Passes if the body only contains objects with ID > 1
      #   require 'rspec-api-matchers'
      #
      #   body = '[{"id": 2}, {"id": 3}]'
      #   obj = OpenStruct.new body: body
      #
      #   describe 'be_filtered' do
      #     include RSpecApi::Matchers::Filter
      #     it { expect(obj).to be_filtered by: :id, value: 1, compare_with: :> }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/lHO7nw be_filtered_spec.rb for more examples
      def be_filtered(options = {})
        RSpecApi::Matchers::Filter::Matcher.new options
      end
    end
  end
end