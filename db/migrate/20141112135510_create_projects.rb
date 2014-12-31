class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
	  t.boolean :active
      t.string :description
	  t.string :holder
      t.string :vm_code
	  t.float :amount
	  t.float :progress_amount
	  t.integer :progress_percent
	  t.string :payback
	  t.integer :tir
	  t.integer :project_type_id
      
	  t.timestamps
    end
  end
end
