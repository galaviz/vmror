class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :description
      t.string :command
      t.boolean :active

      t.timestamps
    end
  end
end
