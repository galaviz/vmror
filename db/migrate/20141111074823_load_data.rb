class LoadData < ActiveRecord::Migration
  def up
    exampleUser =  User.new(:nombre => "Patricio", :apellido => "Gonzalez", :email => "admin@verdemonarca.com", :is_residential => false, :consumo_total => 745640, :importe_total => 1328240.78)
    exampleUser.cargo_fijo = 22097.94
    exampleUser.energia = 111797.19
    exampleUser.puntos_vm = 100
    exampleUser.creditos_vm = 100
    exampleUser.clave_referencia = "PGON1"
    exampleUser.hashed_password = "e4df635c3914bfe704f6398831497977ccfba1e7"
    exampleUser.salt = "456"
    exampleUser.pasos = 0
    exampleUser.profile_id = 1
    exampleUser.country_id = 1
    exampleUser.state_id = 19
    exampleUser.location_id = 40
    exampleUser.calle = "Notre Dame"
    exampleUser.numero_direccion = 115
    exampleUser.colonia = "Valle de San Ángel"
    exampleUser.codigo_postal = "66290"
    exampleUser.save()
	
    exampleUserResidential =  User.new(:nombre => "Maurizio", :apellido => "Calo", :email => "mauriziocalo07@gmail.com", :is_residential => true, :consumo_total => 13110, :importe_total => 52834)
    exampleUserResidential.clave_referencia = "MCAL001"
    exampleUserResidential.cargo_fijo = 78.40
    exampleUserResidential.energia = 2564.93
    exampleUserResidential.hashed_password = "e4df635c3914bfe704f6398831497977ccfba1e7"
    exampleUserResidential.salt = "456"
    exampleUserResidential.puntos_vm = 100
    exampleUserResidential.creditos_vm = 100
    exampleUserResidential.pasos = 0
    exampleUserResidential.profile_id = 1
    exampleUserResidential.country_id = 1
    exampleUserResidential.state_id = 19
    exampleUserResidential.location_id = 40
    exampleUserResidential.calle = "Notre Dame"
    exampleUserResidential.numero_direccion = 115
    exampleUserResidential.colonia = "Valle de San Ángel"
    exampleUserResidential.codigo_postal = "66290"
    exampleUserResidential.save()

  end

  def down
      User.delete_all
  end
end
