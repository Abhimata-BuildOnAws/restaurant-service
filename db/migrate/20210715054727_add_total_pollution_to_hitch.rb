class AddTotalPollutionToHitch < ActiveRecord::Migration[6.1]
  def change
    add_column :hitches, :total_pollution, :float
  end
end
