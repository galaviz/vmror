class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
    	t.float :price
    	t.integer :size_id
    	t.integer :item_id
      t.timestamps
    end
  end
end
