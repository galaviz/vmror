class CategoryController < ApplicationController
	before_action :set_category, only: [:edit, :update, :deactivate]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @categories = Category.all.order(id: :asc)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	end
	
	def create
	  check_permission()
	  @category = Category.new
	  @category.description = params["description"]
	  @category.active = true
	  @category.save()
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
	  @category.description = params["description"]
	  @category.active = true
	  @category.save()
	  redirect_to :action => :index
	end 

	def check_permission
		if SecurityController.has_permission(session[:user_id], "category") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
	def deactivate
		if @category.active
			@category.active = false
		else
			@category.active = true
		end
		@category.save()
		redirect_to :action => :index
	end
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_category
		@category = Category.find(params[:id])
	end

end
