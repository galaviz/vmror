class StatesController < ApplicationController
	def get_states
		states = State.select("id, description").where(country_id: params["country"])
	  	render :json =>  { :success => 1, :state_list => states }.to_json
	end
end
