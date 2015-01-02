class DonationHistoryController < ApplicationController
  
  def index
	check_permission()
	@pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	@configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
	@online_user = User.find_by_id(session["user_id"])
	
	sql = "SELECT dh.id, dh.active, dh.description, dh.amount_mxn, dh.credit_vm, dh.contract_file_name, us.nombre, us.apellido, pj.description as project, dt.description as donation_type FROM donation_histories dh LEFT JOIN users us ON dh.user_id = us.id LEFT JOIN donation_types dt ON dh.donation_type_id = dt.id LEFT JOIN projects pj ON dh.project_id = pj.id"
	fd="" # from date
	td="" # to date
	if params[:fromDate_submit] and params[:toDate_submit]
		fd = DateTime.parse(params[:fromDate_submit] + ' 00:00:00')
		fd = (fd.to_datetime + 6.hour).strftime('%d-%m-%Y %T')
		td = DateTime.parse(params[:toDate_submit] + ' 23:59:59')
		td = (td.to_datetime + 6.hour).strftime('%d-%m-%Y %T')
	elsif
		fd = DateTime.now - 1.month
		fd = (fd.to_datetime + 6.hour).strftime('%d-%m-%Y %T')
		td = DateTime.now
		td = (td.to_datetime + 6.hour).strftime('%d-%m-%Y %T')
	end
	sql += " WHERE dh.created_at >= '" + fd + "' AND dh.created_at <= '" + td + "'"
	if params[:user] != "" and params[:user] != nil
	  # using ~* for case insensitive http://www.postgresql.org/docs/8.3/static/functions-matching.html#FUNCTIONS-POSIX-TABLE
	  sql += " AND (us.nombre ~* '" + params[:user] + "' OR us.apellido ~* '" + params[:user] + "') "
	end
	@dh = DonationHistory.find_by_sql(sql)
  end 
  
  def check_permission
  	if SecurityController.has_permission(session[:user_id], "donationHistory") == false
  		redirect_to :action => :monitoring, :controller => :dashboard
  	end
  end
  
end
