class Note < ApplicationRecord
  belongs_to :category
    validates :title, presence: true
    validates :category_id, presence:true
    # validates :user_id, presence: true
end
