class MovieOrder < ApplicationRecord
  belongs_to :movie
  belongs_to :order
end
