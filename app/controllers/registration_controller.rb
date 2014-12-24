class RegistrationController < ApplicationController

  def begin_registration
    reset_session

    session["is_residential"] = params["is_residential"]
    redirect_to(:action => :energy_info)
  end

  def energy_info
      @is_residential = session["is_residential"].to_b
      @months = @is_residential ? ["Enero", "Febrero", "Marzo", "Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre"] :["Enero", "Febrero", "Marzo", "Abril","Abril (2)", "Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Octubre (2)","Noviembre","Diciembre"]

  end

  def post_energy_info
    puts params.inspect
    session["rpu"] = params["rpu"]
	
	if params["exists"] == "0"
		energy_info = EnergyInfo.new
		energy_info.rpu = params["rpu"]
		energy_info.tarifa = params["tarifa"]
		energy_info.cargo_fijo = params["cargo-fijo"]
		energy_info.energia = params["energia"]
		energy_info.consumo_total = params["consumo-total"]
		energy_info.importe_total = params["import-total"]
		energy_info.total_a_pagar = params["import-total"]
		energy_info.save()
	end
	
    redirect_to(:action=>:user_info)
  end

  def user_info
    @is_residential = session["is_residential"]
	@country = Country.select("id, description").where(active: true)
    @state = State.select("id, description").where(active: true)
    @location = Location.select("id, description").where(active: true, state_id: 19)
	
    @rpu=EnergyInfo.find_by(rpu: session[:rpu]) 
    @user = User.new
    @user.nombre = @rpu.nombre
    @user.apellido = @rpu.apellido
	
    puts @user.inspect
  end

  def post_user_info
	if params["email"] != ""
		@user = User.find_by_email(params["email"])
		if @user
			if session[:user_id] and @user.id == session[:user_id]
				rpu=EnergyInfo.find_by(rpu: session[:rpu]) 
				puts "params post user info"
				puts params
				if params["empresa"]
					@user.empresa = params["empresa"]
				end
				@user.is_residential = session["is_residential"]
				@user.nombre = params["nombre"]
				@user.apellido = params["apellido"]
				@user.email = params["email"]
				@user.telefono = params["telefono"]
				@user.celular = params["celular"]
				@user.country_id = params["pais"]
				@user.state_id = params["estado"]
				@user.location_id = params["municipio"]
				@user.calle = params["calle"]
				@user.numero_direccion = params["numero"]
				@user.colonia = params["colonia"]
				@user.codigo_postal = params["codigoPostal"]
				@user.rpu = rpu.rpu
				@user.energia = rpu.energia
				@user.cargo_fijo = rpu.cargo_fijo
				@user.consumo_total = rpu.consumo_total
				@user.importe_total = rpu.importe_total
				@user.pasos = 0
				@user.profile_id = 2
				@user.save()
			else 
				render :json =>  { :success => 0, :messages => "¡El correo ya existe!"}.to_json
			end
		else
			rpu=EnergyInfo.find_by(rpu: session[:rpu]) 
			user = User.new
			puts "params post user info"
			puts params
			if params["empresa"]
				user.empresa = params["empresa"]
			end
			user.is_residential = session["is_residential"]
			user.nombre = params["nombre"]
			user.apellido = params["apellido"]
			user.email = params["email"]
			user.telefono = params["telefono"]
			user.celular = params["celular"]
			user.country_id = params["pais"]
			user.state_id = params["estado"]
			user.location_id = params["municipio"]
			user.calle = params["calle"]
			user.numero_direccion = params["numero"]
			user.colonia = params["colonia"]
			user.codigo_postal = params["codigoPostal"]
			user.rpu = rpu.rpu
			user.energia = rpu.energia
			user.cargo_fijo = rpu.cargo_fijo
			user.consumo_total = rpu.consumo_total
			user.importe_total = rpu.importe_total
			user.pasos = 0
			user.profile_id = 2
			user.save()
			session[:user_id] = user.id
			render :json =>  { :success => 1, :location => 'propuesta'}.to_json
		end
	else
		render :json =>  { :success => 0, :messages => "Hola"}.to_json
	end
  end

  def propuesta
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
	@user.pasos = 1
	@user.save()
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
	@user.pasos = 2
	@user.save()
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
	@user.pasos = 3
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
    @state = State.find_by_id(@user.state_id)
    @location = Location.find_by_id(@user.location_id)
	@user.pasos = 4
	@user.save()
    @signatureDavid = Base64.encode64(File.open("app/assets/customerSignature/signatureDavid.png", "rb").read)
    @headerImage = Base64.encode64(File.open("app/assets/images/Logo_Verde_Monarca.png", "rb").read)
  end

  def post_confirmation
    contractPDF = params[:contract64PDF]
    powerPDF = params[:power64PDF]
    if contractPDF == nil or contractPDF == "" or powerPDF == nil or powerPDF == ""
      render :json => { :success => 0 }.to_json
    else
      user = User.find_by_id(session["user_id"])
      
      contract = user.nombre[0,2] + user.apellido[0,2] + '-' + params[:contract64Name]
      File.open('app/assets/contracts/' + contract + '.pdf',"wb") do |file|
        file.write(Base64.decode64(contractPDF))
      end
      
      power = user.nombre[0,2] + user.apellido[0,2] + '-' + params[:power64Name]
      File.open('app/assets/contracts/' + power + '.pdf',"wb") do |file|
        file.write(Base64.decode64(powerPDF))
      end
      render :json => { :success => 1 }.to_json
    end
  end

  def contract
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
	@user.pasos = 5
	@user.save()
    
    file_name = @user.nombre[0,2] + @user.apellido[0,2]
    @contract1 = 'data:application/pdf;base64,' + Base64.encode64(File.open("app/assets/contracts/" + file_name + "-Contrato_compraventa.pdf", "rb").read)
    @contract2 = 'data:application/pdf;base64,' + Base64.encode64(File.open("app/assets/contracts/" + file_name + "-Carta_Poder.pdf", "rb").read)
  end

  def send_contract
    @user = User.find_by_id(session["user_id"])
    UserMailer.send_contract(@user).deliver
    render :json => { :success => 1 }.to_json
  end

  def welcome
    @user = User.find_by_id(session["user_id"])
    @propuesta= @user.crear_propuesta()
	@user.pasos = 6
	@user.save()
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
	  @user.pasos = 0
    @user.save()
    #if successs
    #send email
    #puts("sending email")
    UserMailer.send_welcome_email(@user).deliver
	session["is_residential"] = nil
	session["rpu"] = nil
    redirect_to(:action=>:monitoring,:controller=>:dashboard)
    #else go back to form. display error message
  end

  def rpu_info
	@user = User.find_by(rpu: params[:rpu]) 
    if @user
  		  render :json =>  { :success => 2 }.to_json
  	else
  		@rpu=EnergyInfo.find_by(rpu: params[:rpu]) 
  		if @rpu
  		  render :json =>  { :success => 1 }.to_json
  		else
  		  render :json =>  { :success => 0, :message => "" }.to_json
  		end
  	end
  end

end
