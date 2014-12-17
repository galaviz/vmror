class LocationsController < ApplicationController
	def get_locations
		locations = Location.select("id, description").where(state_id: params["state"])
	  	render :json =>  { :success => 1, :location_list => locations }.to_json
	end
end
