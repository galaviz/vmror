class CreateEnergyInfos < ActiveRecord::Migration
  def change
    create_table :energy_infos do |t|
      t.string :rpu
      t.string :nombre
      t.string :apellido
      t.string :domicilio
      t.integer :pais
      t.integer :estado
      t.integer :municipio
      t.integer :codigo_postal
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
