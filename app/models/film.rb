class Film < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :genres

  def add_characters(ids)
    characters_to_add = Character.find(ids)
    characters_to_add.each do |char|
      if char.nil?
        errors.add(:characters, message: "Couldn't find character")
        break
      elsif characters.exclude?(char)
        characters << char
      end
    end
  end

  def add_genres(ids)
    genres_to_add = Genre.find(ids)
    genres_to_add.each do |genre|
      if genre.nil?
        errors.add(:genres, message: "Couldn't find genre")
        break
      elsif genres.exclude?(genre)
        genres << genre
      end
    end
  end

end
