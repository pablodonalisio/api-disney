class CharactersController < AuthenticationController
  before_action :set_character, only: %i[show update destroy]

  def index
    if params[:name]
      @character = Character.find_by(name: params[:name])
      redirect_to @character
    else
      @characters = filter_characters(filtering_params)
      render json: @characters.as_json(only: %i[name image_url])
    end
  end

  def show
    render json: @character.as_json(
      except: %i[created_at updated_at],
      include: {
        films: {
          except: %i[created_at updated_at]
        }
      }
    )
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      render json: @character, status: :created, location: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def update
    if @character.update(character_params)
      render json: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @character.destroy
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :image_url, :weight, :story, :age)
  end

  def filtering_params
    params.slice(:age, :weight, :movie)
  end

  def filter_characters(params)
    characters = Character.all
    characters = characters.where(age: params[:age]) if params[:age]
    characters = characters.where(weight: params[:weight]) if params[:weight]
    characters = characters.select { |char| char.films.include?(Film.find(params[:movie])) } if params[:movie]
    characters
  end
end
