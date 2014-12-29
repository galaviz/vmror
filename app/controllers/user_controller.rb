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
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

end
