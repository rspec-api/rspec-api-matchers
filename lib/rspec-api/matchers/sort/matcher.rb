require 'rspec-api/matchers/collection/matcher'

module RSpecApi
  module Matchers
    module Sort
      class Matcher < Collection::Matcher
        attr_accessor :field, :verse

        def initialize(options = {})
          @field = options[:by]
          @verse = options[:verse]
        end

        def matches?(response)
          super && all_objects_have_field? && has_two_objects? && is_sorted?
        end

        def description
          if field
            %Q(be sorted by #{reverse? ? 'descending' : 'ascending'} #{field})
          else
            %Q(be sorted)
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
            msg = "Cannot test sorting on an array with #{json.length} items"
            raise RSpec::Core::Pending::PendingDeclaredInExample.new msg
          else
            true
          end
        end

        def is_sorted?
          values = json.map{|item| item[field]}
          values.sort == (reverse? ? values.reverse : values)
        end

        def reverse?
          ['desc', 'descending'].include? verse.to_s
        end
      end
    end
  end
end