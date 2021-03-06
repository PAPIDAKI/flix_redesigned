class MoviesController < ApplicationController
  before_action :require_signin ,except:[:index,:show]
  before_action :require_admin, except:[:index,:show]

  def index
    case params[:scope]
      when 'hits'
        @movies=Movie.hits
      when 'flops'
        @movies=Movie.flops
      when 'upcoming'
        @movies=Movie.upcoming

      else
    @movies = Movie.released
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @fans=@movie.fans
    @genres=@movie.genres

    if current_user
      @current_favorite=current_user.favorites.find_by(movie_id:@movie.id)
    end
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
  
  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      #flash[:notice]="Movie updated!"
    redirect_to @movie,notice:"Movie Updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice]="Movie Created!"
    redirect_to @movie,notice:"Movie Created!"
    else
      render :new
    end
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url,alert:"Movie Deleted!"
  end
  
private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name,genre_ids:[])
  end
end

