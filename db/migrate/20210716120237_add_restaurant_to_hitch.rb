# frozen_string_literal: true

class AddRestaurantToHitch < ActiveRecord::Migration[6.1]
  def change
    add_reference :hitches, :restaurant, type: :uuid, foreign_key: true
  end
end
