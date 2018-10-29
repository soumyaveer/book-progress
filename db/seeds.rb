require 'json'
require 'rest-client'

User.destroy_all
Book.destroy_all
BookProgression.destroy_all

# Create users
user1 = User.create(
  username: "Harry Potter",
  email: "harry@hogwarts.edu",
  password: "harry1"
)
user2 = User.create(
  username: "Ron Weasley",
  email: "ron_weasel@hogwarts.edu",
  password: "ron1"
)
user3 = User.create(
  username: "Hermoine Granger",
  email: "hermoine_granger@hogwarts.edu",
  password: "smartwitch@1"
)
user4 = User.create(
  username: "James Potter",
  email: "james_potter@hogwarts.edu",
  password: "james_lilly"
)
user5 = User.create(
  username: "Severus Snape",
  email: "severus_snape@hogwarts.edu",
  password: "half_blood_prince"
)

# create books from Google
response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=harry%20potter&maxResults=40&printType=books")
json_response = JSON.parse(response.body)

books = json_response["items"].map do |book_json|
  Book.create!(
    author: book_json["volumeInfo"]["authors"].join(", "),
    cover_url: book_json["volumeInfo"]["imageLinks"]["thumbnail"],
    title: book_json["volumeInfo"]["title"],
    pages: book_json["volumeInfo"]["pageCount"] || (100 + rand(1000))
  )
end

# Create book progressions
[user1, user2, user3, user4, user5].each do |user|
  user_books = books.sample(rand(Book.count))

  user_books.each do |book|
    BookProgression.create!(user: user, book: book, current_page: rand(book.pages))
  end
end