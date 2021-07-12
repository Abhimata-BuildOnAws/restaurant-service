class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.float :pollution

      t.timestamps
    end
  end
end
