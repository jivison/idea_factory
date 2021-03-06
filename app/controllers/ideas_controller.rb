class IdeasController < ApplicationController

    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authenticate!, only: [:new, :create, :update, :destroy, :edit]
    before_action :authorize!, only: [:edit, :update, :destroy]

    def index
        @ideas = Idea.order(title: :desc)
    end

    def show
        @review = Review.new
        @like = Like.find_by(user: current_user, idea: @idea)
    end

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = @current_user
        if @idea.save
            redirect_to @idea
        else
            render :new
        end
    end

    def edit
    end
    
    def update
        if @idea.update idea_params
            redirect_to @idea
        else
            render :edit
        end
    end

    def destroy
        @idea.destroy
        redirect_to :root
    end

    private
    def find_idea
        @idea = Idea.find(params[:id])
    end

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def authorize!
        unless can? :crud, @idea
            redirect_to :root
        end
    end

end
