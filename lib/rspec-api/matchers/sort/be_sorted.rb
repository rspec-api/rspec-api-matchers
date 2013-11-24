require 'rspec-api/matchers/sort/matcher'

module RSpecApi
  module Matchers
    module Sort
      # Passes if the object has a non-empty sorted JSON collection in the body.
      #
      # @param [Hash] options how the body is expected to be sorted.
      # @option options [Symbol or String] :by The JSON key to sort by
      # @option options [Symbol or String] :verse (:asc) The sorting direction
      #
      # Sorting is ascending unless +verse.to_s+ is 'desc' or 'descending'
      #
      # @example Passes if the body is sorted by descending IDs
      #   require 'rspec-api-matchers'
      #
      #   body = '[{"id": 3}, {"id": 2}, {"id": 1}]'
      #   obj = OpenStruct.new body: body
      #
      #   describe 'be_sorted' do
      #     include RSpecApi::Matchers::Sort
      #     it { expect(obj).to be_sorted(by: :id, verse: :desc) }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/UhC4MQ be_sorted_spec.rb for more examples
      def be_sorted(options = {})
        RSpecApi::Matchers::Sort::Matcher.new options
      end
    end
  end
end