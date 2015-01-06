class ProductSizeController < ApplicationController
	before_action :set_product, only: [:index, :new]
	before_action :set_product_size, only: [:edit, :update, :deactivate]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @sizes = ProductSize.where(item_id: @product)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @product = params[:product_id]
	end
	
	def create 
	  ProductSize.create(
		size_description: params[:size_description],
		price: params[:price],
		item_id: params[:product_id],
		active: true
	  )
	  redirect_to :action => :index, :id => params[:product_id]
	end 
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @product = params[:product_id]
	end

	def update 
	  @product_size.size_description = params[:size_description]
	  @product_size.price = params[:price]
	  @product_size.save()
	  redirect_to :action => :index, :id => @product_size.item_id
	end 
	
	def deactivate
		if @product_size.active
			@product_size.active = false
		else
			@product_size.active = true
		end
		@product_size.save()
		redirect_to :action => :index, :id => @product_size.item_id
	end
	
	def check_permission
		if SecurityController.has_permission(session[:user_id], "product_size") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_product
		@product = params[:id]
	end
	def set_product_size
		@product_size = ProductSize.find(params[:id])
	end
end