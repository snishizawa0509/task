class Note < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates :title, presence: true
  validates :category_id, presence: true
  validates :title, length: { maximum: 15 }
  mount_uploader :image, ImageUploader
end
