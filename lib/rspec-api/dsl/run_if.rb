require 'rspec-api/matchers/run_if'

module RSpecApi
  module Matchers
    module DSL
      # Creates a +method_name+_if method for each DSL method
      #
      # @example
      #
      # def have_prev_page_link_if(condition, *args)
      #   RSpecApi::Matchers::RunIf.new condition, have_prev_page_link(*args)
      # end
      RSpecApi::Matchers::DSL.instance_methods.each do |method|
        define_method("#{method}_if") do |condition, *args|
          run_if condition, send(method, *args)
        end
      end

      def run_if(run, matcher)
        RSpecApi::Matchers::RunIf.new run, matcher
      end
    end
  end
end