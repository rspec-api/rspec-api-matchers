require 'rspec-api/matchers/attributes'

module RSpecApi
  module Matchers
    # Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
    # makes RSpecApi::Matchers::Status available as expect(...).to match_status
    module DSL
      # Passes if response body is an object or array of objects with +key+.
      #
      # @example
      #
      #   # Passes if the body is an object with key :id
      #   body = '{"id": 1, "url": "http://www.example.com"}'
      #   expect(OpenStruct.new body: body).to have_attributes(:id)
      #
      #   # Passes if the body is an object with key :id and value 1
      #   body = '{"id": 1, "url": "http://www.example.com"}'
      #   expect(OpenStruct.new body: body).to have_attributes(id: {value: 1})
      #
      #   # Passes if the body is an array of objects, all with key :id
      #   body = '{"id": 1, "name": ""}, {"id": 2}]'
      #   expect(OpenStruct.new body: body).to have_attributes(:id)
      #
      #   # Passes if the body is an array of object with key :id and odd values
      #   body = '{"id": 1, "name": ""}, {"id": 3}], {"id": 5}]'
      #   expect(OpenStruct.new body: body).to have_attributes(id: {value: -> v {v.odd?}})

      # TODO: add &block options
      def have_attributes(attributes = {})
        RSpecApi::Matchers::Attributes.new attributes
      end
      # alias have_attribute have_attributes
      # alias have_keys have_attributes
      # alias have_key have_attributes
    end
  end
end