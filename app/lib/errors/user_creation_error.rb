# frozen_string_literal: true

module Errors
  class UserCreationError < StandardError
    def message
      'There was a problem creating this User'
    end
  end
end
