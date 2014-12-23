class StatesController < ApplicationController
	before_action :set_state, only: [:edit, :update, :deactivate]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @states = State.select("states.id, states.description as state, countries.description as country, states.active").joins("LEFT JOIN countries ON countries.id = states.country_id").order(id: :asc)

	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @country_dropdown = Country.where(active: true)
	end
	
	def create
	  check_permission()
	  @state = State.new
	  @state.description = params["description"]
	  @state.country_id = params["country-id"]
	  @state.active = true
	  @state.save()
	  redirect_to :action => :index
	end
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @country_dropdown = Country.where(active: true)
	end 
	
	def update
	  check_permission()
	  @state.description = params["description"]
	  @state.country_id = params["country-id"]
	  @state.active = true
	  @state.save()
	  redirect_to :action => :index
	end 

	def check_permission
		if SecurityController.has_permission(session[:user_id], "states") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
	def deactivate
		if @state.active
			@state.active = false
		else
			@state.active = true
		end
		@state.save()
		redirect_to :action => :index
	end

	def get_states
		states = State.select("id, description").where(state_id: params["state"])
	  	render :json =>  { :success => 1, :state_list => states }.to_json
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_state
		@state = State.find(params[:id])
	end
end
