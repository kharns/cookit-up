class Recipe < ApplicationRecord
  include PgSearch::Model

  belongs_to :fridge_scan
  has_one_attached :photo

  validates :title, :guest, :ingredient_list, :content, :difficulty, :cooking_time, presence: true

  after_create_commit :generate_photo

  pg_search_scope :search_by_all,
  against: [ :title, :ingredient_list, :content ],
  using: {
    tsearch: { prefix: true }
  }

  private

  def generate_photo
    CreateImageJob.perform_later(self)
  end
end
