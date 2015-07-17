class SessionsController < ApplicationController
  def create
	@user = User.create(user_params)
	if @user.save
		session[:user_id] = @user.id
		redirect_to home_path
	else
		render :signup
	end
  end


  def signup
  	@user = User.new
  end

  def attempt_login

  	if params[:username].present? && params[:password].present?
  	      found_user = User.where(username: params[:username]).first
  	      if found_user
  	        @authorized_user = found_user.authenticate(params[:password])
  	        if @authorized_user
  	        	session[:user_id] = @authorized_user.id
  	        	redirect_to home_path, flash: {success: "You're logged in!"}
  	        else
  	        	render :login
  	        end
  	      else
  	      	render :login
  	      end
  	else
  	  	render :login
  	end
  end

  def logout
	session[:user_id] = nil
	redirect_to login_path
  end

  def home
  end

  private
  def user_params
  	params.require(:user).permit(:username,:password,:password_digest)
  end

end
