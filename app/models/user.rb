class User < ActiveRecord::Base
  def authenticate(password)

    expected_password = encrypted_password(password, self.salt)
    return self.hashed_password == expected_password
  end

  def password_valid(password)
    expected_password = encrypted_password(password, self.salt)
    return self.hashed_password == expected_password
  end

  # 'password' is a virtual attribute
  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = encrypted_password(self.password, self.salt)
  end


  def encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt # 'wibble' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.id.to_s + rand.to_s
  end

  def user_tier
    @points = self.puntos_vm
    if @points <= 1000
      return "Bronce"
    elsif @points <= 5000
      return "Plata"
    elsif @points <= 50000
      return "Oro"
    elsif @points <= 100000
      return "Platino"
    else
      return "Verde"
    end
  end

  #STUB method. TODO: Implement this to prevent duplicates
  def crear_clave_referencia
    self.clave_referencia = self.nombre[0] + self.apellido[0..2].upcase + "001"
  end

  def crear_propuesta
    if self.is_residential
      return crear_propuesta_residencial
    else
      return crear_propuesta_comercial
    end
  end

  def crear_propuesta_residencial
    #CONSTANTS
    @FACTOR_MINIMO_PRODUCCION = 0.8
    @FACTOR_EXCESO_PRODUCCION = 1.2
    @PERFORMANCE = 1694
    @LIMITES_CONSUMO = { "Pequeño" => 850, "Mediano" => 450, "Grande" => 0}
    @COSTOS_POR_WATT = { "Pequeño" => 3.0, "Mediano" => 2.75, "Grande" => 2.60}
    @COSTOS_PROMEDIOS = { "Pequeño" => 1.8208235294117647, "Mediano" => 0.8793333333333333, "Grande" => 0.8793333333333333}
    @COSTO_MANTENIMIENTO = 3000
    @ARBOLES_CONSTANT = 0.0005
    @CO2_CONSTANT = 0.00067
    @DURACION = 25
    @IRR_STUBS = { "Pequeño" => 26.9, "Mediano" => 19.1, "Grande" => 18.5}
    @PAYBACK_STUBS = { "Pequeño" => 4, "Mediano" => 6, "Grande" => 6}

    #Init
    propuesta = Hash.new
    propuesta['Pequeño'] = Hash.new
    propuesta['Mediano'] = Hash.new
    propuesta['Grande'] = Hash.new

    #shared vars
    consumo_mensual_promedio = self.consumo_total / 12.0
    depuracion = self.cargo_fijo / self.energia

    #different calculations for different sizes
    propuesta["Pequeño"]['produccion_anual'] = (consumo_mensual_promedio - @LIMITES_CONSUMO["Pequeño"]) * @FACTOR_EXCESO_PRODUCCION * 12
    propuesta["Mediano"]['produccion_anual'] = (consumo_mensual_promedio - @LIMITES_CONSUMO["Mediano"]) * @FACTOR_EXCESO_PRODUCCION * 12
    propuesta["Grande"]['produccion_anual'] = (consumo_mensual_promedio - @LIMITES_CONSUMO["Grande"]) * @FACTOR_MINIMO_PRODUCCION * 12

    #same calculations for different sizes
    propuesta.keys.each do |size|
        propuesta[size]['tamano'] = (propuesta[size]['produccion_anual'] / @PERFORMANCE) * @FACTOR_EXCESO_PRODUCCION
        propuesta[size]['costo_anual_sin_vm'] = self.importe_total / 1.16 #importe subtotal (no incluye IVA)
        propuesta[size]['ahorro_energetico'] = self.consumo_total - propuesta[size]['produccion_anual']
        propuesta[size]['ahorro_energetico_porcentaje'] = 100 - (100 * propuesta[size]['ahorro_energetico'] / self.consumo_total)
        propuesta[size]['costo_anual'] = (propuesta[size]['ahorro_energetico']*@COSTOS_PROMEDIOS[size]) + (self.importe_total * depuracion / 1.16) + @COSTO_MANTENIMIENTO
        propuesta[size]['ahorro_economico'] = propuesta[size]['costo_anual_sin_vm'] - propuesta[size]['costo_anual']
        propuesta[size]['ahorro_economico_porcentaje'] = 100 * propuesta[size]['ahorro_economico'] / propuesta[size]['costo_anual_sin_vm']
        propuesta[size]['ahorro_economico_en_vida'] = @DURACION * propuesta[size]['ahorro_economico']
        propuesta[size]['arboles_no_talados'] = @ARBOLES_CONSTANT * propuesta[size]['produccion_anual'] * @DURACION
        propuesta[size]['co2'] = @CO2_CONSTANT * propuesta[size]['produccion_anual'] * @DURACION
        propuesta[size]['costo_por_watt'] = @COSTOS_POR_WATT[size]
        propuesta[size]['inversion_total'] =  1000 * propuesta[size]['costo_por_watt'] * propuesta[size]['tamano']
        propuesta[size]['payback'] = @PAYBACK_STUBS[size]
        propuesta[size]['tir'] = @IRR_STUBS[size]
    end
    return propuesta
  end

  def crear_propuesta_comercial
      #CONSTANTS
      vm_sizes = ["25", "50", "75", "100"]
      @PERFORMANCE = 1657
      @FOCOS_CONSTANT  = 0.00856
      @ARBOLES_CONSTANT = 0.0005
      @CO2_CONSTANT = 0.00067
      @DURACION = 25
      @COSTOS_POR_WATT = { "25" => 2.20, "50" => 2.15, "75" => 2.10, "100" => 2.05}
      @IRR_ARR = { "25" => 14.8, "50" => 15.1, "75" => 15.4, "100" => 15.7}
      depuracion = self.cargo_fijo / self.energia

      # Init hash
      propuesta = Hash.new
      vm_sizes.each do |size|
        propuesta[size] = Hash.new
        propuesta[size]['tamano'] = self.consumo_total * size.to_i / (100 * @PERFORMANCE)
        propuesta[size]['produccion_anual'] = self.consumo_total * size.to_i / 100
        propuesta[size]['costo_anual_sin_vm'] = self.importe_total
        propuesta[size]['ahorro_economico'] = self.importe_total * (size.to_f) * (1 - depuracion) / 100
        propuesta[size]['ahorro_economico_en_vida'] = @DURACION * propuesta[size]['ahorro_economico']
        propuesta[size]['costo_anual'] = self.importe_total - propuesta[size]['ahorro_economico']
        propuesta[size]['ahorro_economico_porcentaje'] = 100.0 * propuesta[size]['ahorro_economico'] / self.importe_total
        propuesta[size]['ahorro_energetico'] = propuesta[size]['tamano'] * @PERFORMANCE
        propuesta[size]['ahorro_energetico_porcentaje'] = size.to_i
        propuesta[size]['arboles_no_talados'] = @ARBOLES_CONSTANT * propuesta[size]['ahorro_energetico'] * @DURACION
        propuesta[size]['co2'] = @CO2_CONSTANT * propuesta[size]['ahorro_energetico'] * @DURACION
        propuesta[size]['costo_por_watt'] = @COSTOS_POR_WATT[size]
        propuesta[size]['inversion_total'] = 1000 * propuesta[size]['costo_por_watt'] * propuesta[size]['tamano']
        propuesta[size]['payback'] = 7
        propuesta[size]['tir'] = @IRR_ARR[size]


      end
      return propuesta
  end

end
