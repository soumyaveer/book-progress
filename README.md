[![CircleCI](https://circleci.com/gh/soumyaveer/book-progress.svg?style=svg)](https://circleci.com/gh/soumyaveer/book-progress)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

# BookProgress

Book Progress helps you track your reading progress and watch what others are reading. Read more it [here](https://www.soumyathinks.com/technology/projects/book-progress).

<a href="https://www.soumyathinks.com/technology/projects/book-progress"><img src="https://www.soumyathinks.com/assets/images/technology-projects/book-progress.png"></a>

## Developing

1. Clone the repository (https://github.com/soumyaveer/book-progress)
2. Run `bundle install` and `yarn install`
3. Run `rake db:create && rake db:setup`
4. Run `foreman start -f Procfile.development` to start the server at http://localhost:5000.


## Running tests

1. Run `RACK_ENV=test rake db:schema:load` to initialize the schema on the test database
2. Run `rake spec` to run tests.
3. [CI status](https://circleci.com/gh/soumyaveer/book-progress). 

## Tech

* Ruby, Sinatra
* Javascript (ES6), React
* PostgreSQL
* Heroku
* CircleCI

## Contributing:

Bug reports and pull requests are welcome on GitHub at https://github.com/soumyaveer/book-progress


## License:

The application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
