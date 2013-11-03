require 'rspec-api/matchers/sort'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response body is sorted by +options[:by]+ with +options[:verse]+
      #
      # @example
      #
      #   # Passes if the body is sorted by ascending IDs
      #   body = '[{"id": 1}, {"id": 2}, {"id": 3}]'
      #   expect(OpenStruct.new body: body).to be_sorted(by: :id)
      #
      #   # Passes if the body is sorted by descending timestamps
      #   body = '[{"t": "2013-10-29T18:09:43Z"}, {"t": "2009-01-12T18:09:43Z"}]'
      #   expect(OpenStruct.new body: body).to be_sorted(by: :t, verse: :desc)
      def be_sorted(options = {})
        RSpecApi::Matchers::Sort.new options
      end
    end
  end
end