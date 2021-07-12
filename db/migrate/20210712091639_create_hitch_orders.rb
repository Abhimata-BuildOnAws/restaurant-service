class CreateHitchOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :hitch_orders, id: :uuid do |t|
      t.uuid :hitch_id
      t.uuid :order_id

      t.timestamps
    end
  end
end
