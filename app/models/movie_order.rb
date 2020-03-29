class MovieOrder < ApplicationRecord
  belongs_to :movie
  belongs_to :order

  validates :quantity, :movie_price, presence: true
end
