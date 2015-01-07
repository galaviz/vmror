class UserController < ApplicationController
	before_action :set_user, only: [:edit, :update]

	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @users = User.all.order(id: :asc)
	end
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @profiles = Profile.select("id, description").where(active: true).order(id: :asc)
	  @country = Country.select("id, description").where(active: true)
	  @state = State.select("id, description").where(active: true)
	  @location = Location.select("id, description").where(active: true)
	end 
	
	def update
	  check_permission()
	  @user.rpu = params["rpu"]
	  @user.empresa = params["empresa"]
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
	  @user.codigo_postal = params["codigo-postal"]
	  @user.profile_id = params["profile"]
	  @user.puntos_vm = params["puntos-vm"]
	  @user.creditos_vm = params["creditos-vm"]
	  @user.save()
	  redirect_to :action => :index
	end 

	def check_permission
		if SecurityController.has_permission(session[:user_id], "user") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end

	def tipo_de_cliente
		check_permission()
		@pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
		@configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
		@online_user = User.find_by_id(session["user_id"])
		@users = User.all.order(id: :asc)
	end

	def begin_registration
	    #reset_session

	    session["is_residential"] = params["is_residential"]
	    redirect_to(:action => :energy_info)
	end

	def energy_info
		check_permission()
		@pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
		@configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
		@is_residential = session["is_residential"].to_b
		@online_user = User.find_by_id(session["user_id"])
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
		check_permission()
		@pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
		@configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
		@is_residential = session["is_residential"].to_b
		@online_user = User.find_by_id(session["user_id"])
		@country = Country.select("id, description").where(active: true)
		@state = State.select("id, description").where(active: true)
		@location = Location.select("id, description").where(active: true, state_id: 19)

		@rpu=EnergyInfo.find_by(rpu: session[:rpu]) 
		@user = User.new
		@user.nombre = @rpu.nombre
		@user.apellido = @rpu.apellido
		@user.codigo_postal = @rpu.codigo_postal
		@user.calle = @rpu.domicilio

		puts @user.inspect
	end

	  def post_user_info
	  	
              if params["email"] != ""
                     @user = User.find_by_email(params["email"])
                     if @user
                            render :json =>  { :success => 0, :messages => "¡El correo ya existe!"}.to_json
                     else
                            rpu=EnergyInfo.find_by(rpu: session[:rpu]) 
                            user = User.new
                            #puts "params post user info"
                            #puts params
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
                            user.pasos = 1
                            user.profile_id = 2
                            user.crear_clave_referencia()
                            user.save()
                            success = 1
                            messages = ""
                            UserMailer.send_registration().deliver
                            render :json =>  { :success => 1, :messages => "¡Correo enviado!", :location => '/user'}.to_json
                     end
              else
                     render :json =>  { :success => 0, :messages => "¡El correo es requerido!"}.to_json
              end
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
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

end
