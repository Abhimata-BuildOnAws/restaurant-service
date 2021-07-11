class AddPasswordToRestaurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :password_digest, :string
  end
end
