class FavoritesController < ApplicationController
	before_action :require_signin
	before_action :set_movie
	def create

		#find movie
		#add favorite by the user
		@fav_movie=@movie.favorites.create(user:current_user)
		 #redirect_to
		redirect_to @movie,notice:'Thanks mate!'
	end

	def destroy
		favorite=current_user.favorites.find(params[:id])
		favorite.destroy

		redirect_to @movie,notice:'Hated it eh?'
	end

	private
	def set_movie
		@movie=Movie.find(params[:movie_id])
	end





end
