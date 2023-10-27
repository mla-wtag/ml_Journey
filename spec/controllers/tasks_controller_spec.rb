require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:assignment) { FactoryBot.create(:assignment) }
  let!(:task) { FactoryBot.create(:task, creator: user, user_ids: user.id) }
  before { sign_in(user) }

  describe 'GET #index' do
    let(:task2) { FactoryBot.create(:task, creator: user, user_ids: user.id) }

    it 'populates an array of all Tasks' do
      get :index, params: { user_id: user.id }
      expect(assigns(:tasks)).to match_array [task, task2]
    end

    it 'renders the :index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a task' do
        task_attributes = FactoryBot.attributes_for(:task, user_ids: user.id)
        expect {
          post :create, params: { user_id: user.id, task: task_attributes }
        }.to change(Task, :count).by(1)
      end

      it 'redirects to the tasks index' do
        task_attributes = FactoryBot.attributes_for(:task, user_ids: user.id)
        post :create, params: { user_id: user.id, task: task_attributes }
        expect(response).to redirect_to user_tasks_path(user)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { title: nil, description: nil } }

      it 'does not save the new task in the database' do
        expect {
          post :create, params: { user_id: user.id, task: invalid_attributes }
        }.to_not change(Task, :count)
      end

      it 're-renders the :new template with unprocessable entity status' do
        post :create, params: { user_id: user.id, task: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the task' do
        patch :update, params: { user_id: user.id, id: task.id, task: { title: 'Updated Title' } }
        task.reload
        expect(task.title).to eq('Updated Title')
      end

      it 'redirects to the task show page' do
        patch :update, params: { user_id: user.id, id: task.id, task: { title: 'Updated Title' } }
        expect(response).to redirect_to user_task_path(user)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the task' do
        patch :update, params: { user_id: user.id, id: task.id, task: { title: nil } }
        task.reload
        expect(task.title).not_to be_nil
      end

      it 're-renders the :edit template with unprocessable entity status' do
        patch :update, params: { user_id: user.id, id: task.id, task: { title: nil } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user1) { FactoryBot.create(:user) }
    it 'deletes the task' do
      expect {
        delete :destroy, params: { user_id: user.id, id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it 'redirects to the tasks index' do
      delete :destroy, params: { user_id: user.id, id: task.id }
      expect(response).to redirect_to user_tasks_path(user)
    end
  end
end
