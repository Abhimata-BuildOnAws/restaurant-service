class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants, id: :uuid do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :contact_no
      t.timestamps
    end
  end
end
