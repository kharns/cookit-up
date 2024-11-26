class FridgeScan < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :photo
  has_many :recipes
end
