class CreatePagePermissions < ActiveRecord::Migration
  def change
    create_table :page_permissions do |t|
      t.integer :page_id
      t.integer :permission_id
      t.boolean :active

      t.timestamps
    end
  end
end
