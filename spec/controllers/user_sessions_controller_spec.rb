require 'rails_helper'
RSpec.describe UserSessionsController, type: :controller do
  describe 'GET user_sessions#new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid user credentials' do
      let!(:session_user) do
        FactoryBot.create(:user,
                          id: 1,
                          firstname: 'Michael',
                          lastname: 'Lavelanet',
                          employee_id: '1234',
                          date_of_birth: '2004-12-12',
                          joining_day: '2004-12-12',
                          designation: 'Junior Software Engineer',
                          email: 'Mail',
                          password: 'code')
      end

      it 'sets the session user_id' do
        post :create, params: { user: { firstname: 'Michael', password: 'code' } }
        session_user.reload
        expect(session[:user_id]).to eq(session_user.id)
      end

      it 'redirects to the user show page' do
        post :create, params: { user: { firstname: 'Michael', password: 'code' } }
        session_user.reload
        expect(response).to redirect_to(user_path(session_user))
      end
    end

    context 'with invalid user credentials' do
      it 'redirects to the root path' do
        post :create, params: { user: { firstname: 'Invalid', password: 'wrong' } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
