class RegistrationController < ApplicationController

  def begin_registration
    session["user_id"] = nil
    reset_session

    is_residential = params["is_residential"]
    session["is_residential"] = is_residential
    redirect_to(:action => :energy_info)
  end

  def user_info
    @is_residential = session["is_residential"]
    if session["user_id"] and User.find_by_id(session["user_id"])
      @user = User.find_by_id(session["user_id"])
    else
      @user = User.new
      @user.is_residential = @is_residential
      @user.save()
      session["user_id"] = @user.id
    end
    puts @user.inspect
  end

  def post_user_info
    if params["email"] != ""
      
      @user = User.find_by_email(params["email"])
      if @user
        render :json =>  { :success => 0, :messages => "¡El correo ya existe!"}.to_json
      else
        
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
        user.codigo_postal = params["codigoPostal"]
        user.save()
        
        render :json =>  { :success => 1}.to_json
      end
      
    else
      
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
      user.codigo_postal = params["codigoPostal"]
      user.save()
      render :json =>  { :success => 1}.to_json
      
    end
  end

  def energy_info
      @is_residential = session["is_residential"]
    if session["user_id"] and User.find_by_id(session["user_id"])
      @user = User.find_by_id(session["user_id"])
    else
      @user = User.new
      @user.is_residential = @is_residential
      @user.save()
      session["user_id"] = @user.id
    end
      @user = User.find_by_id(session["user_id"])
      @months = @is_residential ? ["Enero", "Febrero", "Marzo", "Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre"] :["Enero", "Febrero", "Marzo", "Abril","Abril (2)", "Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Octubre (2)","Noviembre","Diciembre"]

  end

  def post_energy_info
    puts params.inspect
    @rpu=InfoEnergetica.find_by(rpu: params[:rpu]) 
    user = User.find_by_id(session["user_id"])
    user.rpu = @rpu.rpu
    user.energia = @rpu.energia
    user.cargo_fijo = @rpu.cargo_fijo
    user.consumo_total = @rpu.consumo_total
    user.importe_total = @rpu.importe_total
    user.nombre = @rpu.name
    user.apellido = @rpu.apellido
    puts user.inspect
    user.save()
    redirect_to(:action=>:user_info)
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
    signature = params[:signature]
    if signature == nil or signature == ""
      render :json => { :success => 0 }.to_json
    else
      user = User.find_by_id(session["user_id"])
      file_name = user.nombre[0] + user.apellido[0,2]
      File.open('app/assets/customerSignature/' + file_name + '.png',"wb") do |file|
        file.write(Base64.decode64(signature))
      end
      render :json => { :success => 1 }.to_json
    end
  end

  def contract
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
    
    file_name = @user.nombre[0] + @user.apellido[0,2]
    @signature = Base64.encode64(File.open("app/assets/customerSignature/" + file_name + ".png", "rb").read)
    @signatureDavid = Base64.encode64(File.open("app/assets/customerSignature/signatureDavid.png", "rb").read)
    
  end

  def save_contract
    contractPDF = params[:contract64PDF]
    powerPDF = params[:power64PDF]
    if contractPDF == nil or contractPDF == "" or powerPDF == nil or powerPDF == ""
      render :json => { :success => 0 }.to_json
    else
      user = User.find_by_id(session["user_id"])
      
      contract = user.nombre[0] + user.apellido[0,2] + '-' + params[:contract64Name]
      File.open('app/assets/contracts/' + contract + '.pdf',"wb") do |file|
        file.write(Base64.decode64(contractPDF))
      end
      
      power = user.nombre[0] + user.apellido[0,2] + '-' + params[:power64Name]
      File.open('app/assets/contracts/' + power + '.pdf',"wb") do |file|
        file.write(Base64.decode64(powerPDF))
      end
      render :json => { :success => 1 }.to_json
    end
  end

  def send_contract
    @user = User.find_by_id(session["user_id"])
    UserMailer.send_contract(@user).deliver
    render :json => { :success => 1 }.to_json
  end

  def welcome
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
    file_name = @user.nombre[0] + @user.apellido[0,2]
    if File.exist?('app/assets/customerSignature/' + file_name + '.png')
      File.delete('app/assets/customerSignature/' + file_name + '.png')
    end
  end

  def post_registration
    @user = User.find_by_id(session["user_id"])
    @user.crear_clave_referencia()
    @user.creditos_vm = 100
    @user.puntos_vm = 100
    @user.password=(params["account-password"])
    @user.save()
    #if successs
    #send email
    #puts("sending email")
    UserMailer.send_welcome_email(@user).deliver
    redirect_to(:action=>:monitoreo,:controller=>:dashboard)
    #else go back to form. display error message
  end

  def rpu_info
    @rpu=InfoEnergetica.find_by(rpu: params[:rpu]) 
    if @rpu
      render :json =>  { :success => 1 }.to_json
    else
      render :json =>  { :success => 0 }.to_json
    end
  end

end
