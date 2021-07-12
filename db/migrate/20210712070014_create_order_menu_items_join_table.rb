class CreateOrderMenuItemsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :orders, :menu_items do |t|
      t.index :order_id
      t.index :menu_item_id
    end
  end
end
