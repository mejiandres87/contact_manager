class WelcomeController < ApplicationController
    def index
        @contacts = current_user.contacts.paginate(page: params[:page], per_page: 10)
    end
end