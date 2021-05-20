class Character < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  after_initialize :init

  def init
    self.image_url ||= 'unknown'
    self.age ||= 'unknown'
    self.weight ||= 'unknown'
    self.story ||= 'unknown'
  end
end
