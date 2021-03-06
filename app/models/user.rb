class User < ApplicationRecord
  has_many :book_progressions, dependent: :destroy
  has_many :books, through: :book_progressions

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :username, :email, uniqueness: true
  validates :password, presence: true

  def as_json(_options = nil)
    super(only: [
      :email,
      :id,
      :username
    ])
  end

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    User.all.detect { |user| user.slug == slug }
  end
end
