class GenresController < AuthenticationController
  before_action :set_genre, only: %i[update destroy show]

  def index
    @genres = Genre.all
    render json: @genres.as_json(except: %i[created_at updated_at])
  end

  def show
    render json: @genre.as_json(except: %i[created_at updated_at])
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      render json: @genre, status: :created, location: @genre
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  def update
    if @genre.update(genre_params)
      render json: @genre
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @genre.destroy
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :image_url)
  end
end
