class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items, id: :uuid do |t|
      t.references :restaurant, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :description
      t.float :price
      t.timestamps
    end
  end
end
