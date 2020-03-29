class Order < ApplicationRecord
  belongs_to :customer
  has_many :movies, through: :movie_orders

  validates :reference_number, uniqueness: true
  validates :reference_number, :pst_rate, :gst_rate, :subtotal,
            :total, :address, presence: true
end
