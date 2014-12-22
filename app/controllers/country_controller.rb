class CountryController < ApplicationController
	before_action :set_country, only: [:edit, :update, :deactivate]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @countries = Country.all.order(id: :asc)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	end
	
	def create
	  check_permission()
	  @country = Country.new
	  @country.description = params["description"]
	  @country.active = true
	  @country.save()
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
	  @country.description = params["description"]
	  @country.active = true
	  @country.save()
	  redirect_to :action => :index
	end 

	def check_permission
		if SecurityController.has_permission(session[:user_id], "countries") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
	def deactivate
		if @country.active
			@country.active = false
		else
			@country.active = true
		end
		@country.save()
		redirect_to :action => :index
	end
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_country
		@country = Country.find(params[:id])
	end

end
