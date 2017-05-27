require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let (:task) { create :task }
  let (:comment) { create(:comment, task: task)}
  let(:headers) { task.project.user.create_new_auth_token }

  let(:comment_attr) { attributes_for :comment }

  describe 'GET /api/v1/task/:task_id/comments' do
    it 'Should respond with 200(OK)' do
      create_list(:comment, Random.new.rand(1..9), task: task)
      get api_v1_task_comments_path(task), headers: headers

      expect(response).to be_success
    end

    it 'Should respond with 401(Unauthorized)' do
      get api_v1_task_comments_path(task)

      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'POST /api/v1/task/:task_id/comments' do
    it 'Should respond with 201(Created)' do
      post api_v1_task_comments_path(task), params: { comment: comment_attr }, headers: headers

      expect(response).to be_success
    end

    it 'Should respond with 422(Unprocessable entity)' do
      post api_v1_task_comments_path(task), params: { comment: { text: '' } }, headers: headers

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'Should respond with 401(Unauthorized)' do
      post api_v1_task_comments_path(task)

      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'DELETE /api/v1/comments/:id' do
    it 'Should respond with 200(OK)' do
      delete api_v1_comment_path(comment), headers: headers

      expect(response).to be_success
    end

    it 'Should respond with 401(Unauthorized)' do
      delete api_v1_comment_path(comment)

      expect(response).to have_http_status :unauthorized
    end
  end
end
