class LoadEnergyData < ActiveRecord::Migration
  def up
    energy = EnergyInfo.new
    energy.rpu = "376780500123";
    energy.nombre = "Jorge";
    energy.apellido = "Arrambide";
    energy.tarifa = 7.5;
    energy.cargo_fijo = 78.40;
    energy.energia = 2564.93;
    energy.consumo_total = 13110;
    energy.importe_total = 52834;
    energy.total_a_pagar = 52834;
    energy.save()
    
    energy = EnergyInfo.new
    energy.rpu = "415020400019";
    energy.nombre = "Comercializadora";
    energy.apellido = "Merco";
    energy.tarifa = 15;
    energy.cargo_fijo = 22097.94;
    energy.energia = 111797.19;
    energy.consumo_total = 745640;
    energy.importe_total = 1328240.78;
    energy.total_a_pagar = 1328240.78;
    energy.save()

    energy = EnergyInfo.new
    energy.rpu = "415020400119";
    energy.nombre = "Celso";
    energy.apellido = "Ramirez";
    energy.tarifa = 15;
    energy.cargo_fijo = 22097.94;
    energy.energia = 111797.19;
    energy.consumo_total = 745640;
    energy.importe_total = 1328240.78;
    energy.total_a_pagar = 1328240.78;
    energy.save()
    
  end
end

