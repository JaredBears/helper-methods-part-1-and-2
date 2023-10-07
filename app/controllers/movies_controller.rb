class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    matching_movies = Movie.all

    @movies = matching_movies.order({ :created_at => :desc })

    respond_to do |format|
      format.json do
        render(json: @movies)
      end

      format.html do
        render("movies/index" )
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(params.require(:movie).permit(:title, :description))

    if @movie.valid?
      @movie.save
      redirect_to(movies_url, { notice: "Movie created successfully." })
    else
      render("movies/new")
    end
  end

  def edit
    @movie  = Movie.find(params[:id])
  end

  def update
    movie = Movie.find(params[:id])

    movie.title = params[:movie][:title]
    movie.description = params[:movie][:description]

    if movie.valid?
      movie.save
      redirect_to(movie_url(movie), { notice: "Movie updated successfully."} )
    else
      redirect_to(movie_url(movie), { alert: "Movie failed to update successfully." })
    end
  end

  def destroy
    movie = Movie.find(params[:id])

    movie.destroy

    redirect_to(movies_url, { notice: "Movie deleted successfully."} )
  end
end
