class ReviewsController < ApplicationController
    def create

        
        @review = Review.new params.require(:review).permit(:body)
        @review.user = @current_user
        @review.idea = Idea.find(params[:idea_id])
        if can?(:create, @review)
            if @review.save
                redirect_to @review.idea
            else
                render "../ideas/show"
            end
        else
            redirect_to new_session_path
        end
    end
    
    def destroy
        review = Review.find(params[:id])
        if can?(:destroy, review)
            redirect_to review.idea if review.destroy
        else
            redirect_to new_session_path
        end
    end
end
