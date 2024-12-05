class Recipe < ApplicationRecord
  belongs_to :fridge_scan
  has_one_attached :photo

  validates :title, :guest, :ingredient_list, :content, :difficulty, :cooking_time, presence: true

  after_create_commit :generate_photo

  private

  def generate_photo
    CreateImageJob.perform_later(self)
  end
end
