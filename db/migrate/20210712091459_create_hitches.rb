# frozen_string_literal: true

class CreateHitches < ActiveRecord::Migration[6.1]
  def change
    create_table :hitches, id: :uuid, &:timestamps
  end
end
