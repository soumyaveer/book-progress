# Setup database connection
DATABASE_URLS = {
  development: "postgresql://soumya@localhost/book-progress-development",
  test: "postgresql://soumya@localhost/book-progress-test",
  production: ENV["DATABASE_URL"],
}.freeze

# "postgres://myuser:mypass@localhost/somedatabase"
current_database_url = DATABASE_URLS[ENV["SINATRA_ENV"].to_sym]
puts "Using PG URL: #{current_database_url}"

ActiveRecord::Base.establish_connection(current_database_url)
