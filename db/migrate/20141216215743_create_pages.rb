class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :description
      t.string :command
      t.integer :order_by
      t.integer :menu_id
      t.boolean :active

      t.timestamps
    end
  end
end
