class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new params.require(:user).permit(:password, :email, :name)
        if @user.save
            session[:user_id] = @user.id
            redirect_to :root
        else
            render :new
        end
    end

end
