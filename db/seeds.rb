require 'json'
require 'rest-client'

User.destroy_all
Book.destroy_all
BookProgression.destroy_all

# Create users
users = 32.times.map do
  User.create(
    username: Faker::Name.name,
    email: Faker::Internet.email,
    password: "demo"
  )
end

users << User.create(
  username: "countolaf",
  email: "count@olaf.com",
  password: "demo"
)

# create books from Google
book_terms = [
  "harry potter",
  "the lord of the rings",
  "game of thrones",
  "twilight",
  "the hunger games",
  "the raven cycle",
  "big magic",
  "the diviners",
  "illuminae",
  "cinder",
  "divergent",
  "vicious",
  "mirage",
  "shogun",
  "the poppy war"
]

json_book_items = book_terms.collect_concat do |book_term|
  response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{URI.encode(book_term)}&maxResults=5&printType=books")
  JSON.parse(response.body)["items"]
end

json_book_items = json_book_items.select do |book_item_json|

  book_item_json["volumeInfo"]["authors"].present? \
     && book_item_json["volumeInfo"]["averageRating"].present? \
     && book_item_json["volumeInfo"]["imageLinks"].present? \
     && book_item_json["volumeInfo"]["imageLinks"]["thumbnail"].present? \
     && book_item_json["volumeInfo"]["title"].present? \
     && book_item_json["volumeInfo"]["pageCount"].present? \
     && book_item_json["volumeInfo"]["industryIdentifiers"]\
     && book_item_json["volumeInfo"]["industryIdentifiers"].detect {|isbn| isbn["type"] == "ISBN_13" && isbn["identifier"]}
end

books = json_book_items.map do |book_item_json|
  Book.create!(
    authors: book_item_json["volumeInfo"]["authors"].join(", "),
    cover_url: book_item_json["volumeInfo"]["imageLinks"]["thumbnail"],
    isbn_13: book_item_json["volumeInfo"]["industryIdentifiers"].detect {|isbn| isbn["type"] == "ISBN_13" }["identifier"],
    pages: book_item_json["volumeInfo"]["pageCount"],
    rating: book_item_json["volumeInfo"]["averageRating"],
    title: book_item_json["volumeInfo"]["title"]
  )
end


# Create book progressions
users.each do |user|
  user_books = books.sample(rand(Book.count))

  user_books.each do |book|
    BookProgression.create!(user: user, book: book, current_page: rand(book.pages))
  end
end

puts "Books created: #{Book.count}"
puts "User created: #{User.count}"
