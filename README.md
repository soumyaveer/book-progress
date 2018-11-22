[![CircleCI](https://circleci.com/gh/soumyaveer/book-progress.svg?style=svg)](https://circleci.com/gh/soumyaveer/book-progress)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

# BookProgress

Helps you track your reading progress and watch what others are reading.

## Features:

1. Keep a track of books you are reading and see your progress on each book.
2. See what books others are reading and track their progress.


## Developing

1. Clone the repository (https://github.com/soumyaveer/book-progress)
2. Run `bundle install`
3. Run `rake db:migrate`
4. Run `foreman start -f Procfile.development` to start the server at http://localhost:5000.


## Running tests

1. Run `RACK_ENV=test rake db:schema:load` to initialize the schema on the test database
2. Run `rake spec` to run tests.


## Contributing:

Bug reports and pull requests are welcome on GitHub at https://github.com/soumyaveer/book-progress


## License:

The application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
