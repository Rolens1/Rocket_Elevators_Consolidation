class AdminController < ApplicationController
    protect_from_forgery prepend: true
    before_action :authenticate_user!, only: %i[ index show edit update destroy ]


    # def dropbox    
    #     client = DropboxApi::Client.new(ENV["DROPBOX_OAUTH_BEARER"])
    #     puts client.get_current_account
    # end
end