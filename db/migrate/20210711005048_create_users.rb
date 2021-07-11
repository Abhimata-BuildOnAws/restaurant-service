# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
      t.string :name
      t.string :address
      t.string :password_digest
      t.timestamps
    end
  end
end
