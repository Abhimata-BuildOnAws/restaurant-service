class AddStripeIdToRestaurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :stripe_id, :string
  end
end
