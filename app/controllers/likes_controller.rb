class LikesController < ApplicationController

    def create
        like = Like.create(user: @current_user, idea: Idea.find(params[:idea_id]))
        if like.save
            redirect_to like.idea
        end
    end

    def destroy
        like = Like.find(params[:id ])
        if like.destroy
            redirect_to like.idea
        end
    end
    
end
