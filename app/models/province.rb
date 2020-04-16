class Province < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :pst_rate, :gst_rate, :hst_rate, presence: true
  has_many :customers

  has_one_attached :image
end
