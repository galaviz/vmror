class MainController < ApplicationController
  def index
    reset_session
  end

  def logout
    reset_session
    redirect_to :action => :index
  end

  def login
    @user = User.find_by_email(params["email"])
    if @user
		location = ""
		success = 0
		messages = ""
		session["user_id"] = @user.id
		case @user.pasos
		when 0
			if @user.authenticate(params["passwordinput"])
				location = "/dashboard/monitoreo"
				success = 1
			else
				session["user_id"] = nil
				success = 0
				messages = "¡Contraseña incorrecta!"
			end
		when 1
			location = "/registration/propuesta"
			success = 1
		when 2
			location = "/registration/fecha_visita"
			success = 1
		when 3
			location = "/registration/forma_pago"
			success = 1
		when 4
			location = "/registration/confirmation"
			success = 1
		when 5
			location = "/registration/contract"
			success = 1
		when 6
			location = "/registration/welcome"
			success = 1
		end
		render :json =>  { :success => success, :location => location, :messages => messages}.to_json
    else
      render :json =>  { :success => 0, :messages => "¡Usuario no existe!"}.to_json
    end
  end

  

end



