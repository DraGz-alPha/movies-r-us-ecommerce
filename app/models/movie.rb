class Movie < ApplicationRecord
  has_many :orders, through: :movie_orders
  has_many :genres, through: :movie_genres
  has_many :producers, through: :movie_producers
end
