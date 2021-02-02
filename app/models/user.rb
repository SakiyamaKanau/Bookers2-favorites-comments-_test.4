class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites
  has_many :favorited_books, through: :favorites, source: :book
  has_many :book_comments

  attachment :profile_image
  validates :name, presence: true, length: {minimum: 2,maximum: 20}
  validates :name, uniqueness:true, length:{ in: 2..20 }
  validates :introduction, length: {maximum: 50}
end