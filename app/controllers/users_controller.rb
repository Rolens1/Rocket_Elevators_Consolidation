class UserController < ApplicationController
    def current_user
        render json: {id: current_user.id}
    end
end
  