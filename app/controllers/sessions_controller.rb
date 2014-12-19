class SessionsController < ApplicationController
	def new

	end

	def create
		if user=User.authenticate(params[:email],params[:password])
			session[:user_id]=user.id
			flash[:notice]="Welcome back ,#{user.name}"
			redirect_to(session[:intender_url] || user)
			session[:intender_url]=nil
		else
			flash.now[:alert]="Invalid email or password"
			render :new
		end
	end

	def destroy
		session[:user_id]=nil
		redirect_to root_url,notice:'You are now signed out!'
	end
end
