class ChangeCoordinatesToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :restaurants, :longitude, 'float USING CAST(longitude AS float)'
    change_column :restaurants, :latitude, 'float USING CAST(latitude AS float)'
  end
end
