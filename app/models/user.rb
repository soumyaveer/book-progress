class User < ActiveRecord::Base
  has_many :book_progressions
  has_many :books, through: :book_progressions

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true,
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :username, :email, uniqueness: true
  validates :password, presence: true

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug}
  end
end
