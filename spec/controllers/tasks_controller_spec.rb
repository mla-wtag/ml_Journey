require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:assignment) { FactoryBot.create(:assignment) }
  let!(:task) { FactoryBot.create(:task, creator: user, user_ids: user.id) }
  before { sign_in(user) }

  describe 'GET #index' do
    let(:task2) { FactoryBot.create(:task, creator: user, user_ids: user.id) }
    before { get :index, params: { user_id: user.id} }
    
    it 'populates an array of all Tasks' do
      expect(assigns(:tasks)).to match_array [task, task2]
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:task_attributes) { FactoryBot.attributes_for(:task, user_ids: user.id) }
      let(:create_action) { post :create, params: { user_id: user.id, task: task_attributes } }

      it 'creates a task' do
        expect { create_action }.to change(Task, :count).by(1)
      end

      it 'redirects to the tasks index' do
        expect(create_action).to redirect_to user_tasks_path(user)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { title: nil, description: nil } }
      let(:create_action) { post :create, params: { user_id: user.id, task: invalid_attributes } }

      it 'does not save the new task in the database' do
        expect { create_action }.to_not change(Task, :count)
      end

      it 're-renders the :new template with unprocessable entity status' do
        expect(create_action).to render_template(:new)
        expect(create_action).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { patch :update, params: { user_id: user.id, id: task.id, task: { title: 'Updated Title' } } }
      
      it 'updates the task' do
        task.reload
        expect(task.title).to eq('Updated Title')
      end

      it 'redirects to the task show page' do
        expect(response).to redirect_to user_task_path(user)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { user_id: user.id, id: task.id, task: { title: nil } } }   
      
      it 'does not update the task' do        
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
  let(:delete_action) { delete :destroy, params: { user_id: user.id, id: task.id} }
    it 'deletes the task' do
      expect { delete_action }.to change(Task, :count).by(-1)
    end

    it 'redirects to the tasks index' do
      expect(delete_action).to redirect_to user_tasks_path(user)
    end
  end
end
