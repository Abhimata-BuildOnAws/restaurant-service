class AddGeocodingToHitch < ActiveRecord::Migration[6.1]
  def change
    add_column :hitches, :pickup, :string
    add_column :hitches, :latitude, :float
    add_column :hitches, :longitude, :float
  end
end
