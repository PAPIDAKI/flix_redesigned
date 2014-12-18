class SessionsController < ApplicationController
	def new

	end

	def create
		if user=User.authenticate(params[:email],params[:password])

			session[:user_id]=user.id
			flash[:notice]="Welcome back ,#{user.name}"
			redirect_to user
		else
			flash.now[:alert]="Invalid email or password"
			render :new
		#redirect to user profile page with cookie
		#params[:password]
		end
	end
end
