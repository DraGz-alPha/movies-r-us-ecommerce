class Producer < ApplicationRecord
  has_many :movies, through: :movie_producers

  validates :name, uniqueness: true
  validates :name, presence: true
end
