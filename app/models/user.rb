class User < ActiveRecord::Base
  has_many :book_progressions
  has_many :books, through: :book_progressions
  
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
