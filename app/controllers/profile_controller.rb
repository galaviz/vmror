class ProfileController < ApplicationController
	before_action :set_profile, only: [:edit, :update, :deactivate]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @profiles = Profile.select("profiles.id, profiles.description as pr, pages.description as pa, profiles.active").joins("LEFT JOIN pages ON profiles.page_id = pages.id").order(id: :asc)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @profile_pages = Page.where(active: true).order(order_by: :asc)
	end
	
	def create
	  check_permission()
	  @profile = Profile.new
	  @profile.description = params["description"]
	  @profile.page_id = params["page-id"]
	  @profile.active = true
	  @profile.save()
	  redirect_to :action => :index
	end
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @profile_pages = Page.where(active: true).order(order_by: :asc)
	end 
	
	def update
	  check_permission()
	  @profile.description = params["description"]
	  @profile.page_id = params["page-id"]
	  @profile.save()
	  redirect_to :action => :index
	end 

	def deactivate
	  check_permission()
	  if @profile.active
		@profile.active = false
	  else
		@profile.active = true
	  end
	  @profile.save()
	  redirect_to :action => :index
	end 

	def check_permission
		if SecurityController.has_permission(session[:user_id], "profiles") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_profile
		@profile = Profile.find(params[:id])
	end

end
