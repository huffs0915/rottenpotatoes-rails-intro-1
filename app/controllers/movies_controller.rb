class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
def index
    
    if params[:sorted_session] #setting up sorted session w/ params 
      session[:sorted_session] = params[:sorted_session]
    end
    
    
   
    if params[:ratings]  #keeping data on how user has filtered ratings into sorted_session 
      session[:ratings] = params[:ratings]
    end
    
    @all_ratings = Movie.all.map(&:rating).uniq  #rating boxes
    @ratings = session[:ratings] ? session[:ratings].keys : @all_ratings #query string parameter for ratings
    
    @movies = Movie.order(session[:sorted_session]).where('rating IN (?)', @ratings)
    
    

    if !params[:ratings] && session[:ratings] #remember session
      flash.keep
      redirect_to movies_path(:sorted_session => session[:sorted_session], :ratings => session[:ratings])
    end
  end

  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
