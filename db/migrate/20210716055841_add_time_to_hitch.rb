class AddTimeToHitch < ActiveRecord::Migration[6.1]
  def change
    add_column :hitches, :submit_time, :datetime
    add_column :hitches, :delivery_time, :datetime
  end
end
