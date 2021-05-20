class FilmsController < ApplicationController
  before_action :set_film, only: %i[show update destroy]

  def index
    @films = Film.all

    render json: @films.as_json(only: %i[title image_url release_date])
  end

  def show
    render json: @film.as_json(except: %i[created_at updated_at])
  end

  def create
    @film = Film.new(film_params)

    if @film.save
      render json: @film, status: :created, location: @film
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  def update
    if @film.update(film_params)
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
