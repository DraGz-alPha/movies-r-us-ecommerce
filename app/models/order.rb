class Order < ApplicationRecord
  belongs_to :customer
  has_many :movie_orders
  has_many :movies, through: :movie_orders

  validates :reference_number, uniqueness: true
  validates :reference_number, :subtotal,
            :total, :address, presence: true
  
  def display_name
    self.reference_number # or whatever column you want
  end
end
