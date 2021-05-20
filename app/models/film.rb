class Film < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :genres
end
