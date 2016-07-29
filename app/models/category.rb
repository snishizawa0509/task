class Category < ApplicationRecord
  has_many :notes
  belongs_to :user
  validates :name, presence: true
  validates :name, length: { maximum: 20 }
end
