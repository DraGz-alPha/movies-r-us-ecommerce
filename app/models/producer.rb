class Producer < ApplicationRecord
  has_many :movies, through: :movie_producers
end
