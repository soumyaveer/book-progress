require "./config/environment"
require "sinatra/reloader"

use Rack::MethodOverride

use UsersController
use BookProgressionsController
run ApplicationController
