require 'rack/utils'

module RSpecApi
  module Matchers
    class ContentType
      def initialize(content_type)
        @content_type = content_type
      end

      def matches?(response)
        @headers = response.headers
        if @headers.key? 'Content-Type'
          @headers['Content-Type'] == @content_type
        end
      end
      alias == matches?

      def failure_message_for_should
        "expected headers to #{description}, but got #{@headers}"
      end

      def failure_message_for_should_not
        "expected headers not to #{description}, but was found"
      end

      def description
        "include 'Content-Type': '#{@content_type}'"
      end
    end
  end
end