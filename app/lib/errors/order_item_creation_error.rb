# frozen_string_literal: true

module Errors
  class OrderItemCreationError < StandardError
    def message
      'There was a problem with your order, you must order from the same restaurant as your Tumpang'
    end
  end
end
