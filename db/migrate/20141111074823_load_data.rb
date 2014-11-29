class LoadData < ActiveRecord::Migration
  def up
    exampleUser =  User.new(:nombre => "Patricio", :apellido => "Gonzalez", :email => "admin@verdemonarca.com", :is_residential => false, :consumo_total => 745640, :importe_total => 1328240.78)
    exampleUser.cargo_fijo = 22097.94
    exampleUser.energia = 111797.19
    exampleUser.puntos_vm = 100
    exampleUser.creditos_vm = 100
    exampleUser.clave_referencia = "PGON1"
    exampleUser.save()
    exampleUserResidential =  User.new(:nombre => "Maurizio", :apellido => "Calo", :email => "mauriziocalo07@gmail.com", :is_residential => true, :consumo_total => 13110, :importe_total => 52834)
    exampleUserResidential.clave_referencia = "MCAL001"
    exampleUserResidential.cargo_fijo = 78.40
    exampleUserResidential.energia = 2564.93
    exampleUserResidential.save()
  end

  def down
      User.delete_all
  end
end
