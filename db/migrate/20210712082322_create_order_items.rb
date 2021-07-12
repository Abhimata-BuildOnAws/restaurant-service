class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.uuid :order_id
      t.uuid :menu_item_id
      t.integer :quantity

      t.timestamps
    end
  end
end
