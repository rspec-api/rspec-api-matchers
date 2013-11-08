require 'json'

module RSpecApi
  module Matchers
    class Sort
      def initialize(options = {})
        @field = options[:by]
        @reverse = options[:verse].to_s == 'desc' || options[:verse].to_s == 'descending' || options[:reverse] == true || options[:ascending] == true || options[:asc] == true || options[:descending] == false || options[:desc] == false
      end

      def matches?(response)
        # If we don't get which field the body should be sorted by, then we
        # say that it's sorted. For instance sort by random... no expectations
        # We might still want to do some check about being a JSON array, though
        if @field.nil?
          true
        else
          @desc = " by #{'descending ' if @reverse}#{@field}" # TODO: use arrows
          @body = response.body
          array = extract_array of: @field, from: @body # what if this fails?
          is_sorted? array, @reverse
        end
      end
      alias == matches?

      def failure_message_for_should
        # NOTE: might just print the (unsorted) fields, not the whole @body
        "expected body to #{description}, but got #{@body}"
      end

      def failure_message_for_should_not
        "expected body not to #{description}, but it was"
      end

      def description
        %Q(be sorted#{@desc})
      end

    private

      def is_sorted?(array, reverse)
        return false unless array.is_a?(Array)
        array.reverse! if reverse
        array == array.sort
      end

      # These go elsewhere

      def extract_array(options = {})
        array = JSON without_callbacks(options[:from])
        if array.is_a?(Array) and array.empty?
          raise RSpec::Core::Pending::PendingDeclaredInExample.new "You are testing if an array is sorted, but the array is empty. Try with more fixtures"
        end
        array.map{|item| item[options[:of].to_s]} # what if it's not an array of hashes?
      rescue JSON::ParserError, JSON::GeneratorError
        raise RSpec::Core::Pending::PendingDeclaredInExample.new "You are testing if an array is sorted, but the array is empty. Try with more fixtures"
      end

      def without_callbacks(something)
        callback_pattern = %r[^.+?\((.*?)\)$]
        something =~ callback_pattern ? something.match(callback_pattern)[1] : something
      end
    end
  end
end