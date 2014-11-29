class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.text :image_url
      t.string :brand_image_url
      t.float :watts
      t.string :lumenes
      t.float :precio
      t.string :vida
      t.string :disponibilidad
      t.timestamps
    end
  end
end
