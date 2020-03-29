class Genre < ApplicationRecord
  has_many :movies, through: :movie_genres

  validates :name, uniqueness: true
  validates :name, presence: true
end
