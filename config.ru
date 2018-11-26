require "./config/environment"
require "sinatra/json"

use Rack::MethodOverride

use BooksController
use BookProgressionsController
use SessionsController
use UsersController

run ApplicationController
