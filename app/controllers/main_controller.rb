class MainController < ApplicationController
  def index
  end

  def logout
    reset_session
    redirect_to :action => :index
  end

  def login
    user = User.find_by_email(params[:email])
    unless user.nil?
      session["user_id"] = user.id
    end
    redirect_to :action => :monitoreo, :controller => :dashboard
  end

end
