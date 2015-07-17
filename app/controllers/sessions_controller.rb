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

  def login
  end

  def home
  end

  private
  def user_params
  	params.require(:user).permit(:username,:password,:password_digest)
  end

end
