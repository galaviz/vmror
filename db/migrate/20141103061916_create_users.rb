class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.boolean :is_residential
      t.string :empresa
      t.string :nombre
      t.string :apellido
      t.string :telefono
      t.string :celular
      t.integer :country_id
      t.integer :state_id
      t.integer :location_id
      t.string :calle
      t.integer :numero_direccion
      t.string :colonia
      t.string :codigo_postal
      t.string :rpu
      t.string :tarifa
      t.float :cargo_fijo
      t.float :energia
      t.float :consumo_total
      t.float :importe_total
      t.float :total_a_pagar
      t.string :tipo_membresia
      t.string :hora_visita
      t.string :fecha_visita
      t.string :forma_pago
      t.string :clave_referencia
      t.string :stripe_id
      t.integer :puntos_vm
      t.string :creditos_vm
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.integer :pasos
      t.integer :profile_id
      t.timestamps
    end
  end
end
