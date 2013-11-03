module RSpecApi
  module Matchers
    class RunIf
      def initialize(run, matcher)
        @run = run
        @matcher = matcher
      end

      def matches?(response)
        !@run || @matcher.matches?(response)
      end
      alias == matches?

      def does_not_match?(response)
        !@run || !matches?(response)
      end

      def failure_message_for_should
        @matcher.failure_message_for_should
      end

      def failure_message_for_should_not
        @matcher.failure_message_for_should_not
      end

      def description
        if @run
          @matcher.description
        else
          if @matcher.respond_to? :description_for_run_if
            %Q{not be expected to #{@matcher.description_for_run_if}}
          else
            %Q{not be expected to #{@matcher.description}}
          end
        end
      end
    end
  end
end