def book_attributes
  {
    author: Faker::Lorem.word,
    cover_url: Faker::Internet.url,
    title: Faker::Lorem.word,
    pages: rand(1000)
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
