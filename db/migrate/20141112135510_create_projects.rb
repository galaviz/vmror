class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :description
	  t.string :holder
      t.string :vm_code
	  t.float :amount
	  t.float :progress_amount
	  t.integer :progress_percent
	  t.integer :payback
	  t.integer :tir
      
	  t.timestamps
    end
  end
end
