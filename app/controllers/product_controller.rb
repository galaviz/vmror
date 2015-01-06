class ProductController < ApplicationController
	before_action :set_product, only: [:edit, :update, :deactivate, :sizes]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  #@products = Item.all.order(id: :asc)
	  @products = Item.select("items.id, 
		items.name, 
		items.description, 
		items.watts,
		items.lumenes,
		items.vida,
		items.fase,
		items.configuracion,
		items.bobina,
		items.motor_ventilador,
		items.garantia,
		items.capacidad,
		items.eficiencia,
		items.disponibilidad as item, 
		categories.description as category, 
		items.active")
		.joins("LEFT JOIN categories ON categories.id = items.category_id")
		.order(id: :asc)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @category_dropdown = Category.where(active: true)
	end
	
	def create
	  check_permission()
	  @product = Item.new
	  @product.name = params["name"]
	  @product.description = params["description"]
	  @product.watts = params["watts"]
	  @product.lumenes = params["lumenes"]
	  # @product.precio = params["precio"]
	  @product.vida = params["vida"]
	  @product.fase = params["fase"]
	  @product.configuracion = params["configuracion"]
	  @product.bobina = params["bobina"]
	  @product.motor_ventilador = params["motor_ventilador"]
	  @product.garantia = params["garantia"]
	  @product.capacidad = params["capacidad"]
	  @product.eficiencia = params["eficiencia"]
	  @product.disponibilidad = params["disponibilidad"]
	  @product.category_id = params["category_id"]
	  @product.active = true
	  @product.image_url = Product.upload(params[:datafile])
	  @product.brand_image_url = Product.upload_brand(params[:datafile_brand])
	  @product.save()
	  redirect_to :action => :index
	end
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @category_dropdown = Category.where(active: true)
	end 
	
	def update
	  check_permission()
	  @product.name = params["name"]
	  @product.description = params["description"]
	  @product.watts = params["watts"]
	  @product.lumenes = params["lumenes"]
	  # @product.precio = params["precio"]
	  @product.vida = params["vida"]
	  @product.fase = params["fase"]
	  @product.configuracion = params["configuracion"]
	  @product.bobina = params["bobina"]
	  @product.motor_ventilador = params["motor_ventilador"]
	  @product.garantia = params["garantia"]
	  @product.capacidad = params["capacidad"]
	  @product.eficiencia = params["eficiencia"]
	  @product.disponibilidad = params["disponibilidad"]
	  @product.category_id = params["category_id"]
	  @product.active = true
	  
	  if params[:datafile]
	  	if File.exist?(@product.image_url)
	  		File.delete(@product.image_url)
	  	end
	  	@product.image_url = Product.upload(params[:datafile])
	  end

	  if params[:datafile_brand]
	  	if File.exist?(@product.brand_image_url)
	  		File.delete(@product.brand_image_url)
	  	end
	  	@product.brand_image_url = Product.upload_brand(params[:datafile_brand])
	  end

	  @product.save()
	  redirect_to :action => :index
	end 
	
	def check_permission
		if SecurityController.has_permission(session[:user_id], "product") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
	def deactivate
		if @product.active
			@product.active = false
		else
			@product.active = true
		end
		@product.save()
		redirect_to :action => :index
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_product
		@product = Item.find(params[:id])
	end

end
