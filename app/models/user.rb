class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  has_many :notes, dependent:  :destroy
  has_many :categories, dependent:  :destroy
  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
end
