class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.text :image_url
      t.text :brand_image_url
      t.float :watts
      t.string :lumenes
      # t.float :precio
      t.string :vida
      t.string :fase
      t.string :configuracion
      t.string :bobina
      t.string :motor_ventilador
      t.string :garantia
      t.string :capacidad
      t.string :eficiencia
      t.string :disponibilidad
      t.integer :category_id
      t.boolean :active
      t.timestamps
    end
  end
end
