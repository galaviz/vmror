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
    energy.domicilio = "Magnolia 210, Los Colorines"
    energy.pais = 1;
    energy.estado = 19;
    energy.municipio = 47;
    energy.codigo_postal = 66275;
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
    energy.domicilio = "Mezquital Sta. Rosa 124, Valle del Mezquital"
    energy.pais = 1;
    energy.estado = 19;
    energy.municipio = 5;
    energy.codigo_postal = 67129;
    energy.save()

    energy = EnergyInfo.new
    energy.rpu = "397050801923";
    energy.nombre = "Leonardo";
    energy.apellido = "Huerta G";
    energy.tarifa = "DAC";
    energy.cargo_fijo = 79.94;
    energy.energia = 12079;
    energy.consumo_total = 4386.69;
    energy.importe_total = 1328240.78;
    energy.total_a_pagar = 1328240.78;
    energy.domicilio = "Encino 214, Valle Alto"
    energy.pais = 1;
    energy.estado = 19;
    energy.municipio = 40;
    energy.codigo_postal = 64989;
    energy.save()
    
    energy = EnergyInfo.new
    energy.rpu = "407850400183";
    energy.nombre = "Ravisa";
    energy.apellido = "México SC";
    energy.tarifa = "OM";
    energy.cargo_fijo = 79.94;
    energy.energia = 12079;
    energy.consumo_total = 4386.69;
    energy.importe_total = 1328240.78;
    energy.total_a_pagar = 1328240.78;
    energy.domicilio = "Ramón de Campoamor 1330, Manuel L. Barragán"
    energy.pais = 1;
    energy.estado = 19;
    energy.municipio = 46;
    energy.codigo_postal = 66450;
    energy.save()

    energy = EnergyInfo.new
    energy.rpu = "386990310209";
    energy.nombre = "Jaime";
    energy.apellido = "Escamilla";
    energy.tarifa = "OM";
    energy.cargo_fijo = 79.94;
    energy.energia = 12079;
    energy.consumo_total = 4386.69;
    energy.importe_total = 1328240.78;
    energy.total_a_pagar = 1328240.78;
    energy.domicilio = "Boulevard Río San Juan 1279-2, Aztlán"
    energy.pais = 1;
    energy.estado = 28;
    energy.municipio = 52;
    energy.codigo_postal = 88740;
    energy.save()

  end
end

