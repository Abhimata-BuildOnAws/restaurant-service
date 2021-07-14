class AddGeoCodingToUserAndRestaurant < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :address, :street
    rename_column :restaurants, :address, :street
    add_column :users, :state, :string
    add_column :restaurants, :state, :string
    add_column :users, :country, :string
    add_column :restaurants, :country, :string
    add_column :users, :latitude, :float
    add_column :restaurants, :latitude, :float
    add_column :users, :longitude, :float
    add_column :restaurants, :longitude, :float
  end
end
