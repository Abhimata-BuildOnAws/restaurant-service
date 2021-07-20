class CreateRestaurant < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants, id: :uuid do |t|
      enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
      t.string :name
      t.string :email
      t.string :contact_no
      t.string :street
      t.string :state
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
