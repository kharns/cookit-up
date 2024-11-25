class Recipe < ApplicationRecord
  belongs_to :fridge_scan
  has_one_attached :photo
end
