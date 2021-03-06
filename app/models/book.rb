class Book < ApplicationRecord
  has_many :book_progressions, dependent: :destroy
  has_many :users, through: :book_progressions

  validates :cover_url, :preview_url, presence: true
  validates :isbn_13, presence: true, uniqueness: true
  validates :pages, presence: true, numericality: true
  validates :rating, numericality: true
  validates :title, presence: true
end
