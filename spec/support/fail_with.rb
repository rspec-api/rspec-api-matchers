module RSpec
  module Matchers
    def fail_with(message)
      raise_error RSpec::Expectations::ExpectationNotMetError, message
    end

    def be_pending_with(message)
      raise_error RSpec::Core::Pending::PendingDeclaredInExample, message
    end
  end
end