class Book < ActiveRecord::Base
  has_many :book_progressions
  has_many :users, through: :book_progressions

  validates :title, presence: true
  validates :pages, presence: true, numericality: true

  def self.order_by_created_at
    Book.order(created_at: :desc)
  end
end
