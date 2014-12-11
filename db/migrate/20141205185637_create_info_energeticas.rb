class CreateInfoEnergeticas < ActiveRecord::Migration
  def change
    create_table :info_energeticas do |t|
      t.string :rpu
      t.string :name
      t.string :apellido
      t.string :tarifa
      t.float :cargo_fijo
      t.float :energia
      t.float :consumo_total
      t.float :importe_total
      t.float :total_a_pagar

      t.timestamps
    end
  end
end
