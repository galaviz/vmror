class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :description
      t.integer :state_id
      t.boolean :active

      t.timestamps
    end
  end
end
