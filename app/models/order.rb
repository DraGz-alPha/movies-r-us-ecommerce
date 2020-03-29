class Order < ApplicationRecord
  belongs_to :customer
  has_many :movies, through: :movie_orders
end
