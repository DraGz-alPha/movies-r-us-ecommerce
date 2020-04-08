class Province < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :pst_rate, :gst_rate, presence: true

  has_one_attached :image
end
