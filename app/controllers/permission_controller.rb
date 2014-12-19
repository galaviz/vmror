class PermissionController < ApplicationController
	before_action :set_permission, only: [:edit, :update, :deactivate]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @permissions = Permission.order(id: :asc)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	end
	
	def create
	  check_permission()
	  @permission = Permission.new
	  @permission.description = params["description"]
	  @permission.command = params["command"]
	  @permission.active = true
	  @permission.save()
	  redirect_to :action => :index
	end
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	end 
	
	def update
	  check_permission()
	  @permission.description = params["description"]
	  @permission.command = params["command"]
	  @permission.save()
	  redirect_to :action => :index
	end 

	def deactivate
	  check_permission()
	  if @permission.active
		@permission.active = false
	  else
		@permission.active = true
	  end
	  @permission.save()
	  redirect_to :action => :index
	end 

	def check_permission
		if SecurityController.has_permission(session[:user_id], "permissions") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_permission
		@permission = Permission.find(params[:id])
	end

end
