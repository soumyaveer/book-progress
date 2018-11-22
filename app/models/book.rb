class Book < ApplicationRecord
  has_many :book_progressions, dependent: :destroy
  has_many :users, through: :book_progressions

  validates :title, presence: true
  validates :pages, presence: true, numericality: true
  validates :cover_url, presence: true
end
