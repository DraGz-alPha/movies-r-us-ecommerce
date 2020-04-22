class Order < ApplicationRecord
  belongs_to :customer
  has_many :movie_orders
  has_many :movies, through: :movie_orders

  validates :reference_number, uniqueness: true
  validates :reference_number, :subtotal,
            :total, :address, :order_status, presence: true

  def display_name
    reference_number # or whatever column you want
  end
end
