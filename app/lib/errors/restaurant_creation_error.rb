# frozen_string_literal: true

module Errors
  class RestaurantCreationError < StandardError
    def message
      'There was a problem creating this Restaurant'
    end
  end
end
