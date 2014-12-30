class ProjectController < ApplicationController
	before_action :set_project, only: [:edit, :update, :deactivate, :project_info]
	
	def index
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @projects_all = Project.order(id: :asc)
	end
	
	def new
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @project_type = ProjectType.where(active: true)
	end
	
	def create
	  check_permission()
	  @project = Project.new
	  @project.description = params["description"]
	  @project.holder = params["holder"]
	  @project.vm_code = params["vm_code"]
	  @project.amount = params["amount"]
	  @project.progress_amount = params["progress_amount"]
	  @project.progress_percent = params["progress_percent"]
	  @project.payback = params["payback"]
	  @project.tir = params["tir"]
	  @project.project_type_id = params["project_type_id"]
	  @project.active = true
	  @project.save()
	  redirect_to :action => :index
	end
	
	def edit
	  check_permission()
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	  @online_user = User.find_by_id(session["user_id"])
	  @project_type = ProjectType.where(active: true)
	end 
	
	def update
	  check_permission()
	  @project.description = params["description"]
	  @project.holder = params["holder"]
	  @project.vm_code = params["vm_code"]
	  @project.amount = params["amount"]
	  @project.progress_amount = params["progress_amount"]
	  @project.progress_percent = params["progress_percent"]
	  @project.payback = params["payback"]
	  @project.tir = params["tir"]
	  @project.project_type_id = params["project_type_id"]
	  @project.save()
	  redirect_to :action => :index
	end 

	def deactivate
	  check_permission()
	  if @project.active
		@project.active = false
	  else
		@project.active = true
	  end
	  @project.save()
	  redirect_to :action => :index
	end 

	def project_info
		render :json => {:success => 1, :project => @project}.to_json
	end 
	
	def check_permission
		if SecurityController.has_permission(session[:user_id], "project") == false
			redirect_to :action => :monitoring, :controller => :dashboard
		end
	end
	
  private
	# Use callbacks to share common setup or constraints between actions.
	def set_project
		@project = Project.find(params[:id])
	end

end
