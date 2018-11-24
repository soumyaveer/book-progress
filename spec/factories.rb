def book_attributes
  {
    authors: Faker::Lorem.word,
    cover_url: Faker::Internet.url,
    isbn_13: Faker::Lorem.word,
    pages: rand(1000),
    rating: rand(5),
    title: Faker::Lorem.word
  }
end

def create_book(attributes = {})
  Book.create!(book_attributes.merge(attributes))
end

def create_user(attributes = {})
  User.create!(user_attributes.merge(attributes))
end

def user_attributes
  {
    email: Faker::Internet.email,
    password: Faker::Lorem.word,
    username: Faker::Internet.username
  }
end
