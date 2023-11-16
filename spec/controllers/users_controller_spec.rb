require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before { sign_in(user) }

  describe 'GET #index' do
    context 'when user has admin role' do
      let(:user) { FactoryBot.create(:user, role: :admin_role) }
      before { sign_in(user) }

      it 'renders the :index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when user has regular role' do
      let(:user) { FactoryBot.create(:user, role: :user_role) }
      before { sign_in(user) }

      it 'not render the :index template and redirects to the show page' do
        get :index
        expect(response).to_not render_template(:index)
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe 'GET users#new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET user#show' do
    before do
      get :show, params: { id: user.id }
    end

    it 'displays the current user attributes with variables' do
      expect(assigns(:user)).to eq(user)
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
      let(:invalid_attributes) { { first_name: nil, last_name: nil } }

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
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #confirm_email' do
    context 'when the user is already confirmed' do
      let(:user) { create(:user, confirmed_at: Time.current, confirmation_token: 'some_token') }

      it 'sets the flash alert' do
        get :confirm_email, params: { id: user.id, confirmation_token: user.confirmation_token }
        expect(flash[:alert]).to eq(I18n.t('validations.confirmation_email'))
      end

      it 'redirects to the root path' do
        get :confirm_email, params: { id: user.id, confirmation_token: user.confirmation_token }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update_role' do
    let(:admin_user) { FactoryBot.create(:user, role: 'admin_role') }
    let(:user_update_to_user) { create(:user, role: 'admin_role') }
    let(:user_update_to_admin) { create(:user, role: 'user_role') }
    before { sign_in(admin_user) }

    it 'updates the users role to user' do
      patch :update_role, params: { id: user_update_to_user.id }
      user_update_to_user.reload
      expect(user_update_to_user.role).to eq('user_role')
    end

    it 'sets a flash notice when updating to user' do
      patch :update_role, params: { id: user_update_to_user.id }
      expect(flash[:alert]).to eq("#{user_update_to_user.first_name} " + I18n.t('alerts.ability_user_role'))
    end

    it 'updates the users role to admin' do
      patch :update_role, params: { id: user_update_to_admin.id }
      user_update_to_admin.reload
      expect(user_update_to_admin.role).to eq('admin_role')
    end

    it 'sets a flash notice when updating to user' do
      patch :update_role, params: { id: user_update_to_admin.id }
      expect(flash[:alert]).to eq("#{user_update_to_admin.first_name} " + I18n.t('alerts.ability_admin_role'))
    end

    it 'redirects to users path' do
      patch :update_role, params: { id: admin_user.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
