module RSpecApi
  module Matchers
    class ContentType
      def initialize(content_type)
        @content_type = content_type
      end

      def matches?(response)
        @headers = response.headers
        @content_type.match @headers['Content-Type'] if @headers.key? 'Content-Type'
      end

      def failure_message_for_should
        "expected headers to #{description}, but got #{@headers}"
      end

      def failure_message_for_should_not
        "expected headers not to #{description}, but got #{@headers}"
      end

      def description
        %Q{include 'Content-Type': '#{@content_type}'}
      end

      def description_for_run_if
        %Q{include any specific 'Content-Type'}
      end
    end
  end
end