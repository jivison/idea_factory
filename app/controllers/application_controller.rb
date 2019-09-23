class ApplicationController < ActionController::Base
    before_action :current_user

    def authenticate!
        redirect_to new_session_path unless @current_user.present?
    end

    private
    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end
end
