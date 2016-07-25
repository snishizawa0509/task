class Category < ApplicationRecord
  has_many :notes
  belongs_to :user
  validates :name, presence: true
end
