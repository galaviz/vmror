class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to new_password_reset_path, :notice => "Correo electrónico enviado con instrucciones para restablecer la contraseña."
  end

  def edit
  	@user = User.find_by_password_reset_token(params[:id])
  	if @user

  	else
  		redirect_to root_url
  	end	
  end

  def update
	@user = User.find_by_password_reset_token!(params[:id])
	if params[:user][:password] == params[:user][:password_confirmation]
	  if @user.password_reset_sent_at < 1.hours.ago
	    redirect_to new_password_reset_path, :notice => "el restablecimiento de la contraseña ha caducado."
	  elsif @user.password=(params[:user][:password])
	  	@user.password_reset_token=""
	  	@user.password_reset_sent_at=""
	  	@user.save()
	    #redirect_to edit_password_reset_path, :notice => "la contraseña se ha cambiado."
	    redirect_to root_url
	  else
	    render :edit
	  end
  	else
  		redirect_to edit_password_reset_path, :notice => "las contraseñas no coinciden."
  	end
  end

end
