User.destroy_all
Book.destroy_all
BookProgression.destroy_all

# Create users
user1 = User.create(username: "Harry Potter",
                    email: "harry@hogwarts.edu",
                    password: "harry1")
user2 = User.create(username: "Ron Weasley",
                    email: "ron_weasel@hogwarts.edu",
                    password: "ron1")
user3 = User.create(username: "Hermoine Granger",
                    email: "hermoine_granger@hogwarts.edu",
                    password: "smartwitch@1")
user4 = User.create(username: "James Potter",
                    email: "james_potter@hogwarts.edu",
                    password: "james_lilly")
user5 = User.create(username: "Severus Snape",
                    email: "severus_snape@hogwarts.edu",
                    password: "half_blood_prince")


# create books
book1 = Book.create(title: "Fantastic Beasts and Where to Find Them.",
                 author: "Newt Scamander",
                 pages: 500)

book2 = Book.create(title: "The Standard Book of Spells, Grade 3",
                 author: "Miranda Goshawk",
                 pages: 800)

book3 = Book.create(title: "Unfogging the Future",
                 author: "Cassandra Vablatsky",
                 pages: 600)

book4 = Book.create(title: "Intermediate Transfiguration",
                 author: "Emeric Switch",
                 pages: 500)

book5 = Book.create(title: "A History of Magic",
                 author: "Bathilda Bagshot",
                 pages: 1000)

book6 = Book.create(title: "A Beginner's Guide to Transfiguration",
                 author: "Emeric Switch",
                 pages: 200)


book7 = Book.create(title: "One Thousand Magical Herbs and Fungi",
                 author: "Phyllida Spore",
                 pages: 200)

book8 = Book.create(title: "Magical Drafts and Potions",
                 author: "Arsenius Jigger",
                 pages: 400)

book9 = Book.create(title: "The Dark Forces: A Guide to Self-Protection",
                 author: "Quentin Trimble",
                 pages: 200)

book10 = Book.create(title: "Voyages with Vampires",
                 author: "Gilderoy Lockhart",
                 pages: 100)


# Create book progressions

BookProgression.create(user_id: user1.id, book_id: book1.id , current_page: 200 )
BookProgression.create(user_id: user2.id, book_id: book1.id, current_page:  100)
BookProgression.create(user_id: user3.id, book_id: book2.id, current_page: 300 )
BookProgression.create(user_id: user3.id, book_id: book5.id, current_page:  800)
BookProgression.create(user_id: user3.id, book_id: book7.id, current_page:  150)
BookProgression.create(user_id: user3.id, book_id: book8.id, current_page:  200)
BookProgression.create(user_id: user3.id, book_id: book1.id, current_page:  450)
BookProgression.create(user_id: user3.id, book_id: book10.id, current_page:  100)
BookProgression.create(user_id: user4.id, book_id: book2.id, current_page:  180)
BookProgression.create(user_id: user4.id, book_id: book3.id, current_page:  400)
BookProgression.create(user_id: user5.id, book_id: book4.id, current_page:  100)
BookProgression.create(user_id: user5.id, book_id: book6.id, current_page:  100)
BookProgression.create(user_id: user1.id, book_id: book8.id, current_page:  50)
BookProgression.create(user_id: user1.id, book_id: book9.id, current_page:  150)
BookProgression.create(user_id: user5.id, book_id: book8.id, current_page:  400)
