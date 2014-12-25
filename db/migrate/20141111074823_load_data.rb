class LoadData < ActiveRecord::Migration
  def up
    exampleUser =  User.new(:nombre => "VM", :apellido => "Admin", :email => "admin@verdemonarca.com", :is_residential => false, :consumo_total => 745640, :importe_total => 1328240.78)
    exampleUser.cargo_fijo = 22097.94
    exampleUser.energia = 111797.19
    exampleUser.puntos_vm = 100
    exampleUser.creditos_vm = 100
    exampleUser.clave_referencia = "PGON1"
    exampleUser.hashed_password = "13dc42d325db5ea37c635086877b0c3fe293a391"
    exampleUser.salt = "10.8679645728665945"
    exampleUser.pasos = 0
    exampleUser.profile_id = 1
    exampleUser.country_id = 1
    exampleUser.state_id = 19
    exampleUser.location_id = 40
    exampleUser.save()
	
    exampleUserResidential =  User.new(:nombre => "VM", :apellido => "Monitoreo", :email => "energymonitoring@verdemonarca.com", :is_residential => true, :consumo_total => 13110, :importe_total => 52834)
    exampleUserResidential.clave_referencia = "MCAL001"
    exampleUserResidential.cargo_fijo = 78.40
    exampleUserResidential.energia = 2564.93
    exampleUserResidential.hashed_password = "ecc4e9fb67a8e0e7bdd021a6c40fc0f25dc2c03d"
    exampleUserResidential.salt = "20.09982087988296706"
    exampleUserResidential.puntos_vm = 100
    exampleUserResidential.creditos_vm = 100
    exampleUserResidential.pasos = 0
    exampleUserResidential.profile_id = 1
    exampleUserResidential.country_id = 1
    exampleUserResidential.state_id = 19
    exampleUserResidential.location_id = 40
    exampleUserResidential.save()
  end

  def down
      User.delete_all
  end
end
