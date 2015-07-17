class SessionsController < ApplicationController
  def create
	@user = User.create(user_params)
	if @user.save
		session[:user_id] = @user.id
		redirect_to home_path, flash: {success: "You're signed up!"}
	else
		render :signup
	end
  end


  def signup
  	@user = User.new
  end

  def login
  	@found_user = User.new
  end

  def attempt_login
	if !@found_user
		@found_user = User.create
	end

  	if params[:username].present? && params[:password].present?
  	      
  	      @found_user = User.where(username: params[:username]).first
  	      
  	      if @found_user
  	        @authorized_user = @found_user.authenticate(params[:password])
  	        if @authorized_user
  	        	session[:user_id] = @authorized_user.id
  	        	redirect_to home_path, flash: {success: "You're logged in!"}
  	        else
  	        	@parker = {errors: "password wrong"}
  	        	render :login
  	        end
  	      else
  	      	@parker = {errors: "User doesn't exist"}
  	      	render :login
  	      end
  	else
  		@parker = {errors: "Need to enter a username AND password"}
  	  	render :login
  	end
  end

  def logout
	session[:user_id] = nil
	redirect_to login_path, flash: {success: "You're logged out!"}
  end

  def home
  end

  private
  def user_params
  	params.require(:user).permit(:username,:password,:password_digest)
  end

end

# <% if @parker %>
# 	<% if @parker[:errors] %>
# 	<ul class="alert alert-danger">
# 	    <%= @parker[:errors] %>
# 	</ul>
# 	<% end %>
# <% end %>
