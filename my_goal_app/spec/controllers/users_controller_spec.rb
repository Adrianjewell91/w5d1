require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end 

  describe "POST #create" do
    context "with valid params" do
      it "logs them in" do
        post :create, params: {user: {email: '123@4.com', password: '234567'}}
        user = User.find_by_email('123@4.com')
        expect(session[:session_token]).to eq(user.session_token)
      end

      it "redirects to the show page" do
        post :create, params: {user: {email: '123@4.com', password: '234567'}}
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "stores errors in flash" do
        post :create, params: {user: {email: '123@4.com', password: '27'}}
        expect(flash[:errors]).to be_present
      end

      it "renders a new page" do
        post :create, params: {user: {email: '123@4.com', password: '27'}}
        expect(response).to render_template('new')
      end
    end
  end
end
