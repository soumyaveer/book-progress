require "./config/environment"
require "sinatra/json"

use Rack::MethodOverride

use UsersController
use BookProgressionsController
run ApplicationController
