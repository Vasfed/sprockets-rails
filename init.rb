require "sprockets"
require "sprockets_helper"
require "sprocket_manager"
require "sprockets_application"

class ActionController::Base
  helper :sprockets
end
