class RegistrationController < ApplicationController

  def begin_registration
    session["user_id"] = nil
    reset_session

    is_residential = params["is_residential"]
    session["is_residential"] = is_residential
    redirect_to(:action => :user_info)
  end

  def user_info
    @is_residential = session["is_residential"]
    if session["user_id"] and User.find_by_id(session["user_id"])
      @user = User.find_by_id(session["user_id"])
    else
      @user = User.new
      session["is_residential"] = @is_residential
      @user.is_residential = @is_residential
      @user.save()
      session["user_id"] = @user.id
    end
    puts @user.inspect
  end

  def post_user_info
    user = User.find_by_id(session["user_id"])
    puts "params post user info"
    puts params
    if params["empresa"]
      user.empresa = params["empresa"]
    end
    user.nombre = params["nombre"]
    user.apellido = params["apellido"]
    user.email = params["email"]
    user.telefono = params["telefono"]
    user.celular = params["celular"]
    user.estado = params["estado"]
    user.municipio = params["municipio"]
    user.calle = params["calle"]
    user.numero_direccion = params["numero"]
    user.colonia = params["colonia"]
    user.codigo_postal = params["codigo-postal"]
    user.save()
    redirect_to(:action=>:energy_info)
  end

  def energy_info
      @is_residential = session["is_residential"]
      @user = User.find_by_id(session["user_id"])
      @months = @is_residential ? ["Enero", "Febrero", "Marzo", "Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre"] :["Enero", "Febrero", "Marzo", "Abril","Abril (2)", "Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Octubre (2)","Noviembre","Diciembre"]

  end

  def post_energy_info
    puts params.inspect
    user = User.find_by_id(session["user_id"])
    user.rpu = params["rpu"]
    user.energia = params["energia"]
    user.cargo_fijo = params["cargo-fijo"]
    user.consumo_total = params["consumo-total"]
    user.importe_total = params["import-total"]
    puts user.inspect
    user.save()
    redirect_to(:action=>:propuesta)
  end

  def propuesta
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
  end

  def post_propuesta
    user = User.find_by_id(session["user_id"])
    choice = params.keys[0]#There should be only one parameter
    user.tipo_membresia = choice
    user.save()
    redirect_to(:action=>:fecha_visita)
  end

  def fecha_visita
    @user = User.find_by_id(session["user_id"])
  end

  def post_fecha_visita
    user = User.find_by_id(session["user_id"])
    user.fecha_visita = params["fecha-visita"]
    user.hora_visita = params["hora-visita"]
    user.save()
    redirect_to(:action=>:forma_pago)
  end

  def forma_pago
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
    puts "propuesta is" + @propuesta.inspect
    puts "tipo_membresia is: " + (@user.tipo_membresia)
    @subtotal = @propuesta[@user.tipo_membresia]["inversion_total"]
    @iva = @subtotal * 0.16
    @total = @subtotal * 1.16
    @user.total_a_pagar = @total
    @user.save()
  end

  def post_forma_pago
    user = User.find_by_id(session["user_id"])
    user.forma_pago = params["payment-selection"]
    user.save()
    redirect_to(:action=>:confirmation)
  end

  def confirmation
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
  end

  def post_confirmation
    redirect_to(:action=>:welcome)
  end

  def welcome
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
  end

  def post_registration
    @user = User.find_by_id(session["user_id"])
    @user.crear_clave_referencia()
    @user.creditos_vm = 100
    @user.puntos_vm = 100
    @user.save()
    #if successs
    #send email
    puts("sending email")
    UserMailer.send_welcome_email(@user).deliver
    redirect_to(:action=>:monitoreo,:controller=>:dashboard)
    #else go back to form. display error message
  end

end
