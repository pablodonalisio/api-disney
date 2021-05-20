class Character < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_and_belongs_to_many :films
  after_initialize :init

  def init
    self.image_url ||= 'unknown'
    self.age ||= 'unknown'
    self.weight ||= 'unknown'
    self.story ||= 'unknown'
  end
end
