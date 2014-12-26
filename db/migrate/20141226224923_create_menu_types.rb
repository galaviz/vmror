class CreateMenuTypes < ActiveRecord::Migration
  def change
    create_table :menu_types do |t|
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
