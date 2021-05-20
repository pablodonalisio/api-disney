class CreateFilms < ActiveRecord::Migration[6.1]
  def change
    create_table :films do |t|
      t.string :image_url
      t.string :title
      t.date :release_date
      t.integer :rating

      t.timestamps
    end
  end
end
