require 'rspec/matchers'

module RSpecApi
  module Matchers
    # Passes if receiver is the same HTTP status code as the argument.
    # The receiver can either be in a symbolic or numeric form.
    #
    # @example
    #
    #   # Passes if 200 corresponds to 200
    #   expect(200).to match_status(200)
    #
    #   # Passes if :ok corresponds to :ok
    #   expect(:ok).to match_status(200)
    def match_status(expected_status)
      RSpecApi::Matchers::MatchStatus.new(expected_status)
    end
  end
end

module RSpec
  module Matchers
    # Make RSpecApi::Matchers available inside RSpec
    include ::RSpecApi::Matchers
  end
end