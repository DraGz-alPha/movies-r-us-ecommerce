class Page < ApplicationRecord
  validates :permalink, uniqueness: true
  validates :title, :permalink, presence: true
end
