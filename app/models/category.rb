class Category < ApplicationRecord
  has_many :notes
  belongs_to :users
  validates :name, presence: true
end
