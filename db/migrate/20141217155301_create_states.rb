class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :description
      t.integer :country_id
      t.boolean :active

      t.timestamps
    end
  end
end
