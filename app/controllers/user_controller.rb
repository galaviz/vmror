class UserController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @users = User.all.order(id: :asc)
	end
	
	def edit
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @profiles = Profile.select("id, description").where(active: true).order(id: :asc)
	end 
	
	def update
	  @user.rpu = params["rpu"]
	  @user.empresa = params["empresa"]
	  @user.nombre = params["nombre"]
	  @user.apellido = params["apellido"]
	  @user.email = params["email"]
	  @user.telefono = params["telefono"]
	  @user.celular = params["celular"]
	  @user.estado = params["estado"]
	  @user.municipio = params["municipio"]
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
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

end
