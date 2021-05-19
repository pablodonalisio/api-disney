class Character < ApplicationRecord
  validates :name, presence: true
  after_initialize :init

  def init
    self.age ||= 'unknown'
    self.weight ||= 'unknown'
    self.story ||= 'unknown'
  end
end
