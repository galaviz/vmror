class CreateProfilePermissions < ActiveRecord::Migration
  def change
    create_table :profile_permissions do |t|
      t.integer :profile_id
      t.integer :permission_id
      t.boolean :active

      t.timestamps
    end
  end
end
