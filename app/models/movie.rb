class Movie < ApplicationRecord
  has_many :movie_orders
  has_many :movie_genres
  has_many :movie_producers
  has_many :orders, through: :movie_orders
  has_many :genres, through: :movie_genres
  has_many :producers, through: :movie_producers

  validates :imdb_id, uniqueness: true
  validates :imdb_id, :title, :description, :price, presence: true
end
