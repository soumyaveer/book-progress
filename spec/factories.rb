def create_user(attributes = {})
  user_attributes = {
    email: Faker::Internet.email,
    password: Faker::Lorem.word,
    username: Faker::Internet.username
  }

  user_attributes.merge!(attributes)

  User.create!(user_attributes)
end