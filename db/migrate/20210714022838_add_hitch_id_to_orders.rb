# frozen_string_literal: true

class AddHitchIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :hitch_id, :uuid
  end
end
