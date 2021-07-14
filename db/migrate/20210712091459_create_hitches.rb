class CreateHitches < ActiveRecord::Migration[6.1]
  def change
    create_table :hitches, id: :uuid do |t|

      t.timestamps
    end
  end
end
