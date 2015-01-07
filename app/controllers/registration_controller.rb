class RegistrationController < ApplicationController

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
      
      contract = user.id.to_s + "-" + user.clave_referencia.to_s + '-' + params[:contract64Name]
      File.open('app/assets/contracts/' + contract + '.pdf',"wb") do |file|
        file.write(Base64.decode64(contractPDF))
      end
      
      power = user.id.to_s + "-" + user.clave_referencia.to_s + '-' + params[:power64Name]
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
    
    file_name = @user.id.to_s + "-" + @user.clave_referencia.to_s
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
    #@user.crear_clave_referencia()
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

end
