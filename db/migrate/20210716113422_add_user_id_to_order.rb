class AddUserIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :user, type: :uuid, foreign_key: true
  end
end
