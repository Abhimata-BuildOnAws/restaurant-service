# frozen_string_literal: true

class RemovePasswordFromUserAndRestaurant < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_digest, :string
    remove_column :restaurants, :password_digest, :string
  end
end
