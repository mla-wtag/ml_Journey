require 'rails_helper'

RSpec.describe JournalsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:journal) { FactoryBot.create(:journal, user: user) }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the :index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a journal' do
        journal_attributes = FactoryBot.attributes_for(:journal)
        expect {
          post :create, params: { user_id: user.id, journal: journal_attributes }
        }.to change(Journal, :count).by(1)
      end

      it 'redirects to the journals index' do
        journal_attributes = FactoryBot.attributes_for(:journal)
        post :create, params: { user_id: user.id, journal: journal_attributes }
        expect(response).to redirect_to user_journals_path(user)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { title: nil, content: nil } }

      it 'does not save the new journal in the database' do
        expect {
          post :create, params: { user_id: user.id, journal: invalid_attributes }
        }.to_not change(Journal, :count)
      end

      it 're-renders the :new template with unprocessable entity status' do
        post :create, params: { user_id: user.id, journal: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the journal' do
        patch :update, params: { user_id: user.id, id: journal.id, journal: { title: 'Updated Title' } }
        journal.reload
        expect(journal.title).to eq('Updated Title')
      end

      it 'redirects to the journal show page' do
        patch :update, params: { user_id: user.id, id: journal.id, journal: { title: 'Updated Title' } }
        expect(response).to redirect_to user_journal_path(user, journal)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the journal' do
        patch :update, params: { user_id: user.id, id: journal.id, journal: { title: nil } }
        journal.reload
        expect(journal.title).not_to be_nil
      end

      it 're-renders the :edit template with unprocessable entity status' do
        patch :update, params: { user_id: user.id, id: journal.id, journal: { title: nil } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the journal' do
      expect {
        delete :destroy, params: { user_id: user.id, id: journal.id }
      }.to change(Journal, :count).by(-1)
    end

    it 'redirects to the journals index' do
      delete :destroy, params: { user_id: user.id, id: journal.id }
      expect(response).to redirect_to user_journals_path(user)
    end
  end
end
