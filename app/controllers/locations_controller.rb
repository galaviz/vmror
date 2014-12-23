class LocationsController < ApplicationController
	before_action :set_location, only: [:edit, :update, :deactivate]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @locations = Location.select("locations.id, locations.description as location, states.description as state, locations.active").joins("LEFT JOIN states ON states.id = locations.state_id").order(id: :asc)

	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @state_dropdown = State.where(active: true)
	end
	
	def create
	  check_permission()
	  @location = Location.new
	  @location.description = params["description"]
	  @location.state_id = params["state-id"]
	  @location.active = true
	  @location.save()
	  redirect_to :action => :index
	end
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @state_dropdown = State.where(active: true)
	end 
	
	def update
	  check_permission()
	  @location.description = params["description"]
	  @location.state_id = params["state-id"]
	  @location.active = true
	  @location.save()
	  redirect_to :action => :index
	end 

	def check_permission
		if SecurityController.has_permission(session[:user_id], "locations") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
	def deactivate
		if @location.active
			@location.active = false
		else
			@location.active = true
		end
		@location.save()
		redirect_to :action => :index
	end
	
	def get_locations
		locations = Location.select("id, description").where(state_id: params["state"])
	  	render :json =>  { :success => 1, :location_list => locations }.to_json
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_location
		@location = Location.find(params[:id])
	end

end
