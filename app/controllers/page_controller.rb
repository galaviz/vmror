class PageController < ApplicationController
	before_action :set_page, only: [:edit, :update, :deactivate, :permissions]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @pages_all = Page.order(id: :asc)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	end
	
	def create
	  check_permission()
	  @page = Page.new
	  @page.description = params["description"]
	  @page.command = params["command"]
	  @page.active = true
	  @page.save()
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
	  @page.description = params["description"]
	  @page.command = params["command"]
	  @page.save()
	  redirect_to :action => :index
	end 

	def deactivate
	  check_permission()
	  if @page.active
		@page.active = false
	  else
		@page.active = true
	  end
	  @page.save()
	  redirect_to :action => :index
	end 

	def permissions
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @available_permissions = Permission.find_by_sql("SELECT * FROM permissions pe WHERE pe.id not in (SELECT permission_id FROM page_permissions WHERE active = true AND page_id = " + @page.id.to_s + ")")
	  @assigned_permissions = PagePermission.find_by_sql(" SELECT pp.id, pe.description FROM page_permissions pp LEFT JOIN permissions pe ON pp.permission_id = pe.id WHERE pp.active = true AND pp.page_id = " + @page.id.to_s)
	end 
	
	def assign_permission
		page_permission = PagePermission.find_by_permission_id(params[:pe])
		if page_permission
			page_permission.active = true
			page_permission.save()
		else
			page_permission = PagePermission.new
			page_permission.page_id = params[:pa]
			page_permission.permission_id = params[:pe]
			page_permission.active = true
			page_permission.save()
		end
		redirect_to :action => "permissions/" + params[:pa]
	end
	
	def remove_permission
		page_permission = PagePermission.find_by_id(params[:pe])
		page_permission.active = false
		page_permission.save()
		redirect_to :action => "permissions/" + params[:pa]
	end
	
	def check_permission
		if SecurityController.has_permission(session[:user_id], "permissions") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_page
		@page = Page.find(params[:id])
	end

end
