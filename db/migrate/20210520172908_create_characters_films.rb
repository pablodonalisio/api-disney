class CreateCharactersFilms < ActiveRecord::Migration[6.1]
  def change
    create_join_table :characters, :films
  end
end
