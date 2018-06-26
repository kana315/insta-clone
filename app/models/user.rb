class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 },
                   uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with:/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum:6 }

  mount_uploader :icon, ImageUploader

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
end
