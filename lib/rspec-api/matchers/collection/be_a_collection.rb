require 'rspec-api/matchers/collection/matcher'

module RSpecApi
  module Matchers
    module Collection
      # Passes if the object has a collection of JSON objects in the body.
      #
      # @example Passes if the body is a JSON array
      #   require 'rspec-api-matchers'
      #
      #   body = '[{"id": 1}, {"name": "foo"}, {"name": "bar"}]'
      #   obj = OpenStruct.new body: body
      #
      #   describe 'be_a_collection' do
      #     include RSpecApi::Matchers::Collection
      #     it { expect(obj).to be_a_collection }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/Bl5qJQ be_a_collection_spec.rb for more examples
      def be_a_collection
        RSpecApi::Matchers::Collection::Matcher.new
      end
    end
  end
end