require 'rspec-api/matchers/collection/matcher'

module RSpecApi
  module Matchers
    module Filter
      class Matcher < Collection::Matcher
        attr_accessor :field, :value, :compare_with

        def initialize(options = {})
          @field = options[:by]
          @value = options[:value]
          @compare_with = options.fetch :compare_with, :==
        end

        def matches?(response)
          super && all_objects_have_field? && has_two_objects? && is_filtered?
        end

        def description
          if field
            %Q(be filtered by #{field}#{compare_with}#{value})
          else
            %Q(be filtered)
          end
        end

      private

        def all_objects_have_field?
          if field
            json.all?{|item| item.is_a?(Hash) && item.key?(field)}
          else
            true
          end
        end

        def has_two_objects?
          if json.length < 2
            msg = "Cannot test filtering on an array with #{json.length} items"
            raise RSpec::Core::Pending::PendingDeclaredInExample.new msg
          else
            true
          end
        end

        def is_filtered?
          values = json.map{|item| item[field]}
          values.all?{|v| v.send compare_with, value}
        end

        def reverse?
          ['desc', 'descending'].include? verse.to_s
        end
      end
    end
  end
end