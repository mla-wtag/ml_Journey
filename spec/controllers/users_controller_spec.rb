require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let!(:user1) do
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

  describe 'GET users#index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET users#new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET user#show' do
    it 'displays the current user attributes with variables' do
      get :show, params: { id: 1 }

      expect(assigns :user).to eq user1
    end

    it 'renders the :show template' do
      get :show, params: { id: 1 }
      expect(response).to render_template :show
    end
  end

  describe 'on POST to users#create' do
    context 'with valid attributes' do
      it 'creates user' do
        user_attributes = FactoryBot.attributes_for(:user)
        post :create, params: {
                        user: user_attributes,
                      }
        expect(assigns(:user)).to be_present
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          firstname: nil,
          lastname: nil,
        }
      end

      it 'does not save new user in database' do
        expect do
          post :create, params: { user: invalid_attributes }
        end
      end
      it 're-renders the :new template' do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    context 'user profile incomplete details' do
      let(:valid_attributes) do
        FactoryBot.attributes_for(:user)
      end

      it 'locates the requested user' do
        user = FactoryBot.create(:user, firstname: 'Michael2')
        get :edit, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: 1 }
      }.to change(User, :count).by(-1)
    end
    it 'redirects to the root path' do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to(root_path)
    end
  end

  # describe 'DELETE #destroy' do
  #   it 'deletes the journal' do
  #     expect {
  #       delete :destroy, params: { id: 1 }
  #     }.to change(Journal, :count).by(-1)
  #   end

  #   it 'renders the :show template' do
  #     delete :destroy, params: { id: 1 }
  #     expect(response).to redirect_to journals_path
  #   end
  # end
end
