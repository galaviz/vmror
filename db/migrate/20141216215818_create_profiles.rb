class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :description
      t.integer :page_id
      t.boolean :active

      t.timestamps
    end
  end
end
