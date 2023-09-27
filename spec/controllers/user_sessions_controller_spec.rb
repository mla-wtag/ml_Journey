require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  let(:password) { 'code' }
  let(:confirmed_user) { FactoryBot.create(:user, password: password, confirmed_at: Time.current) }
  let(:unconfirmed_user) { FactoryBot.create(:user, password: password, confirmed_at: nil) }

  describe 'POST #create' do
    context 'with valid user credentials and confirmed user' do
      it 'sets the session user_id' do
        post :create, params: { user: { email: confirmed_user.email, password: password } }
        expect(session[:user_id]).to eq(confirmed_user.id)
      end

      it 'redirects to the user show page' do
        post :create, params: { user: { email: confirmed_user.email, password: password } }
        expect(response).to redirect_to(user_path(confirmed_user))
      end
    end

    context 'with valid user credentials but unconfirmed user' do
      it 'does not set the session user_id' do
        post :create, params: { user: { email: unconfirmed_user.email, password: password } }
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the root path with an alert' do
        post :create, params: { user: { email: unconfirmed_user.email, password: password } }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('validations.login_invalid_confirmation'))
      end
    end

    context 'with invalid user credentials' do
      it 'does not set the session user_id' do
        post :create, params: { user: { email: 'unsaved_mail@mail.com', password: password } }
        expect(session[:user_id]).to be_nil
        expect(flash[:alert]).to eq(I18n.t('validations.login_invalid_validation'))
      end

      it 'redirects to the root path with an alert' do
        post :create, params: { user: { email: 'unsaved_mail@mail.com', password: password } }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('validations.login_invalid_validation'))
      end
    end
  end
end
