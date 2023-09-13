require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let!(:user1) { FactoryBot.create(:user) }

  describe 'GET users#new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET user#show' do
    before do
      get :show, params: { id: user1.id }
    end

    it 'displays the current user attributes with variables' do
      expect(assigns(:user)).to eq(user1)
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe 'on POST to users#create' do
    context 'with valid attributes' do
      it 'creates user' do
        user_attributes = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_attributes }
        expect(assigns(:user)).to be_present
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { firstname: nil, lastname: nil } }

      it 'does not save new user in database' do
        expect do
          post :create, params: { user: invalid_attributes }
        end.to_not change(User, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'locates the requested user' do
      user = FactoryBot.create(:user)
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: user1.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: user1.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
