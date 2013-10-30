require 'rack/utils'

module RSpecApi
  module Matchers
    class PrevPageLink
      def matches?(response)
        @headers = response.headers
        links = @headers['Link'] || '' # see http://git.io/CUz3-Q
        links =~ %r{<.+?>. rel\="prev"}
      end
      alias == matches?

      def failure_message_for_should
        "expected headers to #{description}, but got #{@headers}"
      end

      def failure_message_for_should_not
        "expected headers not to #{description}, but one was found"
      end

      def description
        %Q{include a link to the previous page}
      end
    end
  end
end