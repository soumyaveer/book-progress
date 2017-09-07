class Book < ActiveRecord::Base
  has_many :book_progressions
  has_many :users, through: :book_progressions

  validates :title, presence: true
  validates :pages, presence: true, numericality: true
end
