class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :description
      t.string :command
      t.integer :order_by
      t.boolean :is_menu
      t.boolean :active

      t.timestamps
    end
  end
end
