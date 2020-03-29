class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :email, :address, uniqueness: true
  validates :address, presence: true
end
