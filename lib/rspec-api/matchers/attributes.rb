require 'json'
require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/array/conversions'

module RSpecApi
  module Matchers
    class Attributes
      def initialize(attributes = {})
        @attributes = as_hash(attributes)
      end

      def matches?(response)
        @body = response.body
        json = extract_symbolized_json_from @body
        # NOTE: Might add this... but might be too strict. For instance, if I
        # ask for ?page=2, I might get an empty array. Maybe in that case I
        # should not even check for attributes? Maybe it can be another best
        # practice: adding query params will not affect the attributes (so I
        # can just check them when there are no query params)... of course
        # unless the query params is ?fields=id,name
        # if json.is_a?(Array) and json.empty?
        #   raise RSpec::Core::Pending::PendingDeclaredInExample.new "You are testing if an array is sorted, but the array is empty. Try with more fixtures"
        # end
        has_attributes? json, @attributes
      rescue JSON::ParserError, JSON::GeneratorError
        false
      end
      alias == matches?

      def failure_message_for_should
        "expected body to #{description}, but got #{@body}"
      end

      def failure_message_for_should_not
        "expected body not to #{description}, but it did"
      end

      def description
        desc = @attributes.map do |name, options|
          text = "#{name}"
          if options.key?(:value)
            text << "="
            text << case options[:value]
              when NilClass then 'nil'
              when Proc then '[Proc value]'
              else "#{options[:value]}"
            end
          end
          if options.key?(:type)
            expected_types = Array.wrap(options.fetch :type, :any)
            types = expected_types.map do |type|
              case type
              when Hash
                type.map do |k, format|
                  case format
                  when Hash, Array
                    "#{k} with attributes"
                  else # Symbol
                    "#{format} #{k}"
                  end
                end.to_sentence(two_words_connector: ' or ', last_word_connector: ', or ')
              else "#{type}"
              end
            end
            text << " (#{types.to_sentence(two_words_connector: ' or ', last_word_connector: ', or ')})" if types.any?
          end
          text
        end.to_sentence
        ['have attributes', desc].join(' ').strip
      end

    private

      def has_attributes?(item_or_items, attributes)
        attributes.deep_symbolize_keys!
        items = Array.wrap item_or_items
        attributes.all? do |name, options|
          has_attribute? items, name, options
        end
      end

      def has_attribute?(items, name, options)
        if items.all?{|item| has_key? item, name}
          values = items.map{|item| item[name]}
          expected_types = Array.wrap(options.fetch :type, :any)
          expected_value = options.fetch :value, :any
          values.all? do |value|
            matches_value?(value, expected_value) && matches_types?(value, expected_types)
          end
        end
      end

      def has_key?(item, name)
        item.key? name
      end


      def matches_value?(value, expected_value)
        case expected_value
        when :any then true
        when Proc then expected_value.call value
        else value == expected_value
        end
      end

      def matches_types?(value, expected_types)
        expected_types.any? do |type|
          matches_type_and_format? value, type
        end
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
        when Hash, Array then value.any? ?has_attributes?(value, as_hash(format)) : true
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

      # These go elsewhere

      def as_hash(anything)
        if anything.is_a? Hash
          anything
        elsif anything.nil?
          {}
        else
          Hash[*Array.wrap(anything).map{|x| x.is_a?(Hash) ? [x.keys.first, x.values.first] : [x, {}]}.flatten]
        end
      end

      def extract_symbolized_json_from(something)
        JSON without_callbacks(something), symbolize_names: true
      end

      def without_callbacks(something)
        callback_pattern = %r[^.+?\((.*?)\)$]
        something =~ callback_pattern ? something.match(callback_pattern)[1] : something
      end
    end
  end
end