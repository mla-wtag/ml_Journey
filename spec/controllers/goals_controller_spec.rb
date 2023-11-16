require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:goal) { FactoryBot.create(:goal, user: user) }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the :index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a goal' do
        goal_attributes = FactoryBot.attributes_for(:goal)
        expect {
          post :create, params: { user_id: user.id, goal: goal_attributes }
        }.to change(Goal, :count).by(1)
      end

      it 'redirects to the goals index' do
        goal_attributes = FactoryBot.attributes_for(:goal)
        post :create, params: { user_id: user.id, goal: goal_attributes }
        expect(response).to redirect_to user_goals_path(user)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { title: nil, content: nil } }

      it 'does not save the new goal in the database' do
        expect {
          post :create, params: { user_id: user.id, goal: invalid_attributes }
        }.to_not change(Goal, :count)
      end

      it 're-renders the :new template with unprocessable entity status' do
        post :create, params: { user_id: user.id, goal: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the goal' do
        patch :update, params: { user_id: user.id, id: goal.id, goal: { title: 'Updated Title' } }
        goal.reload
        expect(goal.title).to eq('Updated Title')
      end

      it 'redirects to the goal show page' do
        patch :update, params: { user_id: user.id, id: goal.id, goal: { title: 'Updated Title' } }
        expect(response).to redirect_to user_goal_path(user, goal)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the goal' do
        patch :update, params: { user_id: user.id, id: goal.id, goal: { title: nil } }
        goal.reload
        expect(goal.title).not_to be_nil
      end

      it 're-renders the :edit template with unprocessable entity status' do
        patch :update, params: { user_id: user.id, id: goal.id, goal: { title: nil } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the goal' do
      expect {
        delete :destroy, params: { user_id: user.id, id: goal.id }
      }.to change(Goal, :count).by(-1)
    end

    it 'redirects to the goals index' do
      delete :destroy, params: { user_id: user.id, id: goal.id }
      expect(response).to redirect_to user_goals_path(user)
    end
  end
end
