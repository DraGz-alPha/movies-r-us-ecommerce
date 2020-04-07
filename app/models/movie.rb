class Movie < ApplicationRecord
  has_many :movie_orders
  has_many :movie_genres
  has_many :movie_producers
  has_many :orders, through: :movie_orders
  has_many :genres, through: :movie_genres
  has_many :producers, through: :movie_producers

  accepts_nested_attributes_for :movie_orders, allow_destroy: true
  accepts_nested_attributes_for :movie_genres, allow_destroy: true
  accepts_nested_attributes_for :movie_producers, allow_destroy: true

  validates :imdb_number, uniqueness: true
  validates :imdb_number, :title, :description, :price, presence: true
end
