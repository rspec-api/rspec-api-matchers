require 'rspec-api/matchers/json/matcher'
require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/keys'

module RSpecApi
  module Matchers
    module Attributes
      class Matcher < Json::Matcher
        attr_accessor :attributes

        def initialize(*attributes, &block)
          @attributes = to_hash attributes
        end

        def matches?(response)
          super && has_attributes?(json, attributes)
        end

        def description
          if attributes.any?
            %Q(have attributes #{attributes})
          else
            %Q(have attributes)
          end
        end

      private

        def has_attributes?(items, attrs)
          attrs.deep_symbolize_keys!
          attrs.all?{|name, options| has_attribute? items, name, options}
        end

        def has_attribute?(items, name, options)
          return false unless Array.wrap(items).all?{|item| item.key? name}
          values = Array.wrap(items).map{|item| item[name]}
          attr_types = Array.wrap(options.fetch :type, :any)
          attr_value = options.fetch :value, :any
          values.all? do |v|
            matches_value?(v, attr_value) && matches_types?(v, attr_types)
          end
        end

        def matches_value?(value, expected_value)
          case expected_value
          when :any then true
          when Proc then expected_value.call value
          else value == expected_value
          end
        end

        def matches_types?(value, expected_types)
          expected_types.any?{|type| matches_type_and_format? value, type}
        end

        def matches_type_and_format?(value, type)
          type = Hash[type, :any] unless type.is_a?(Hash)
          type.any? do |type, format|
            matches_type?(value, type) && matches_format?(value, format)
          end
        end

        def matches_type?(value, type)
          type_to_classes(type).any?{|klass| value.is_a? klass}
        end

        def matches_format?(value, format)
          case format
          when :url then value =~ URI::regexp
          when :integer then value.is_a? Integer
          when :timestamp then DateTime.iso8601 value rescue false
          when :email then value =~ %r{(?<name>.+?)@(?<host>.+?)\.(?<domain>.+?)}
          when Hash, Array then value.any? ? has_attributes?(value, to_hash(format)) : true
          when String then matches_format?(value, format.to_sym)
          when :any then true
          end
        end

        def type_to_classes(type)
          Array.wrap case type
            when :string then String
            when :array then Array
            when :object then Hash
            when :null then NilClass
            when :boolean then [TrueClass, FalseClass]
            when :number then Numeric
            when String then type_to_classes(type.to_sym)
            when :any then Object
          end
        end

        def to_hash(attrs)
          array = Array.wrap(attrs).map do |item|
            item.is_a?(Hash) ? item.to_a.flatten : [item, {}]
          end.flatten
          Hash[*array]
        end
      end
    end
  end
end