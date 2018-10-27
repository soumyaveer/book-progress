require "./config/environment"

use Rack::MethodOverride

use UsersController
use BookProgressionsController
run ApplicationController
