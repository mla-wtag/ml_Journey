require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  let(:valid_user) { FactoryBot.create(:user, email: 'michaellavelanet@mail.com', password: 'code') }
  let(:invalid_user) { FactoryBot.create(:user) }
  describe 'GET user_sessions#new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid user credentials' do
      it 'sets the session user_id' do
        post :create, params: { user: { email: valid_user.email, password: 'code' } }
        expect(session[:user_id]).to eq(valid_user.id)
      end

      it 'redirects to the user show page' do
        post :create, params: { user: { email: valid_user.email, password: 'code' } }
        expect(response).to redirect_to(user_path(valid_user))
      end
    end

    context 'with invalid user credentials' do
      it 'redirects to the root path' do
        post :create, params: { user: { email: 'Invalid', password: 'wrong' } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
