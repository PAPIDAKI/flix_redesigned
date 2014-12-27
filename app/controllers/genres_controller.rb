class GenresController < ApplicationController
	before_action :require_signin
	before_action :require_admin

	def index
		@genres=Genre.all

	end

	def show
		@genre=Genre.find(params[:id])
	end

	def new
		@genre=Genre.new
	end

	def create
		@genre=Genre.find(params[:id])
		if @genre.save(genre_params)
			redirect_to genres_path,notice:"Genre created successfuly!"
		else
			render :new
		end
	end

	def edit
		@genre=Genre.find(params[:id])
	end

	def update
		@genre=Genre.find(params[:id])
		if @genre.update(genre_params)
			redirect_to genres_path,notice:'Genre updated succesfuly'
		else
			render :edit
		end

	end

	def destroy
		@genre=Genre.find(params[:id])
		@genre.destroy
		redirect_to genres_path,notice:'Genre deleted!'


	end

	private
	def genre_params
		params.require(:genre).permit(:name)
	end
end
