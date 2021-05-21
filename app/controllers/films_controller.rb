class FilmsController < ApplicationController
  before_action :set_film, only: %i[show update destroy]

  def index
    if params[:title]
      @film = Film.find_by(title: params[:title])
      redirect_to @film
    else
      @films = Film.all
      @films = @films.order("release_date #{params[:order]}") if params[:order]
      render json: @films.as_json(only: %i[title image_url release_date])
    end
  end

  def show
    render json: @film.as_json(
      except: %i[created_at updated_at],
      include: {
        characters: {
          except: %i[created_at updated_at]
        }
      }
    )
  end

  def create
    @film = Film.new(film_params)
    @film.add_characters(params[:characters_ids]) if params[:characters_ids]
    @film.add_genres(params[:genres_ids]) if params[:genres_ids]

    if @film.errors.empty? && @film.save
      render json: @film, status: :created, location: @film
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  def update
    @film.add_characters(params[:characters_ids]) if params[:characters_ids]
    @film.add_genres(params[:genres_ids]) if params[:genres_ids]

    if @film.errors.empty? && @film.update(film_params)
      render json: @film
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

  def film_params
    params.require(:film).permit(:image_url, :title, :release_date, :rating)
  end
end
