class FilmsController < AuthenticationController
  before_action :set_film, only: %i[show update destroy]

  def index
    if params[:title]
      find_film
    else
      @films = filter_films(filtering_params)
      render json: @films.as_json(only: %i[title image_url release_date])
    end
  end

  def show
    render json: @film.as_json(include: %i[characters genres])
  end

  def create
    @film = Film.new(film_params)
    @film.add_characters(params[:characters_ids]) if params[:characters_ids]
    @film.add_genres(params[:genres_ids]) if params[:genres_ids]

    if @film.errors.empty? && @film.save
      render json: @film.as_json(include: %i[characters genres]),
        status: :created,
        location: @film
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  def update
    @film.add_characters(params[:characters_ids]) if params[:characters_ids]
    @film.add_genres(params[:genres_ids]) if params[:genres_ids]

    if @film.errors.empty? && @film.update(film_params)
      render json: @film.as_json(include: %i[characters genres])
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @film.destroy
  end

  private

  def set_film
    @film = Film.find(params[:id])
  end
  
  def find_film
    if @film = Film.find_by(title: params[:title])
      redirect_to @film
    else
      render json: { error: "Couldn't find the film you're looking for" }, status: :not_found
    end
  end

  def film_params
    params.require(:film).permit(:image_url, :title, :release_date, :rating)
  end

  def filtering_params
    params.slice(:order, :genre)
  end

  def filter_films(params)
    films = Film.all
    films = films.order("release_date #{params[:order]}") if params[:order]
    films = films.select { |film| film.genres.include?(Genre.find(params[:genre])) } if params[:genre]
    films
  end
end
