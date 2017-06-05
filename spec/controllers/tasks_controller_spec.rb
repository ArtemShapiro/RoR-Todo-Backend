require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:task) { create(:task) }
  let (:project) { task.project }
  let(:headers) { project.user.create_new_auth_token }
  let(:task_attr) { attributes_for :task }

  describe 'POST /api/v1/projects/:id/tasks' do
    it 'Should respond with 201(Created)' do
      post api_v1_project_tasks_path(project), params: { task: task_attr }, headers: headers

      expect(response).to be_success
      expect(response).to match_response_schema('task')
    end

    it 'Should respond with 422(Unprocessable entity)' do
      post api_v1_project_tasks_path(project), params: { task: {name: ''} }, headers: headers

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'Should respond with 401(Unauthorized)' do
      post api_v1_project_tasks_path(project)

      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'PATCH /api/v1/tasks/:id' do
    it 'Should respond with 200(OK)' do
      patch api_v1_task_path(task), params: { task: task_attr }, headers: headers

      expect(response).to be_success
      expect(response).to match_response_schema('task') 
    end

    it 'Should respond with 422(Unprocessable entity)' do
      patch api_v1_task_path(task), params: { task: { name: '' } }, headers: headers

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'Should respond with 401(Unauthorized)' do
      patch api_v1_task_path(task)

      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'DELETE /api/v1/projects/:id' do
    it 'Should respond with 200(OK)' do
      delete api_v1_task_path(task), headers: headers

      expect(response).to be_success
    end

    it 'Should respond with 401(Unauthorized)' do
      delete api_v1_task_path(task)

      expect(response).to have_http_status :unauthorized
    end
  end
end
