class MainController < ApplicationController
  def index
  end

  def logout
    reset_session
    redirect_to :action => :index
  end

  def login
    @user = User.find_by_email(params["email"])
    if @user
      if @user.authenticate(params["passwordinput"])
        session["user_id"] = @user.id
        render :json =>  { :success => 1}.to_json
      else
        render :json =>  { :success => 0, :messages => "¡Contraseña incorrecta!"}.to_json
      end
    else
      render :json =>  { :success => 0, :messages => "¡Usuario no existe!"}.to_json
    end
  end

end
