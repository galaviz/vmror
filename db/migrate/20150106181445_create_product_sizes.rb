class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
      t.string :size_description
      t.float :price
      t.integer :item_id
      t.boolean :active

      t.timestamps
    end
  end
end
