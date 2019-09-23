require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

    def current_user
        @current_user ||= FactoryBot.create(:user)
    end

    describe "get #new" do
        def valid_new
            get :new
        end

        context "with a user signed in" do
            before do
                session[:user_id] = current_user.id
            end

            it "should render the new template" do
                valid_new
                expect(response).to(render_template :new)
            end 
            it "should create a new instance of idea" do
                valid_new
                expect(assigns :idea).to(be_a_new Idea)
            end
        end
        context "without a user signed in" do
            it "should redirect to the new sessions page" do
                valid_new
                expect(response).to(redirect_to new_session_path)
            end
        end
    end

    describe "post #create" do

        context "with a user signed in" do
            before do
                session[:user_id] = current_user.id
            end

            def valid_create
                idea = FactoryBot.attributes_for(:idea)
                post :create, params: {idea: idea}
                idea
            end
            context "with valid params" do
    
                it "should create a new idea in the database" do
                    idea = valid_create
                    expect(Idea.find_by(title: idea[:title])).to be
                end
                it "should redirect to that idea's show page" do
                    idea = valid_create
                    expect(response).to(redirect_to Idea.find_by(title: idea[:title]))
                end
            end
            context "with invalid params" do
                def invalid_create
                    idea = FactoryBot.attributes_for(:idea, title: nil)
                    post :create, params: {idea: idea}
                    idea
                end
    
                it "should not create a new idea in the database" do
                    idea = invalid_create
                    expect(Idea.find_by(title: idea[:title])).not_to be
                end
                it "should render the new template" do
                    invalid_create
                    expect(response).to(render_template :new)
                end
            end 
        end
        context "without a user signed in" do
            it "should redirect to the new sessions page" do
                idea = FactoryBot.attributes_for(:idea)
                post :create, params: {idea: idea}
                expect(response).to(redirect_to new_session_path)
            end
        end
    end

end
