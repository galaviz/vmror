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
        redirect_to :action => :monitoreo, :controller => :dashboard
      end
    end
  end

end
