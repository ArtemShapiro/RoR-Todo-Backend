require 'rails_helper'

RSpec.describe 'Projects', type: :request, focus: true do
  let(:user) { create :user }
  let(:headers) { user.create_new_auth_token }
  let(:project_attr) { attributes_for :project }

  describe 'GET /api/v1/projects' do
    it 'Should respond with 200(OK)' do
      create_list(:project, Random.new.rand(1..9), user: user)
      get api_v1_projects_path, headers: headers

      expect(response).to be_success
    end

    it 'Should respond with 401(Unauthorized)' do
      get api_v1_projects_path

      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'POST /api/v1/projects' do
    it 'Should respond with 201(Created)' do
      post api_v1_projects_path, params: { project: project_attr }, headers: headers

      expect(response).to have_http_status :created
    end

    it 'Should respond with 500(Internal Server Error)' do
      post api_v1_projects_path, headers: headers, params: { project: { name: '' } }

      expect(response).to have_http_status :internal_server_error
    end

    it 'Should respond with 401(Unauthorized)' do
      post api_v1_projects_path

      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'PATCH /api/v1/projects/:id' do
    let (:project) { create(:project, user: user) }

    it 'Should respond with 200(OK)' do
      patch api_v1_project_path(project), params: { project: project_attr }, headers: headers

      expect(response).to be_success
    end

    it 'Should respond with 500(Internal Server Error)' do
      patch api_v1_project_path(project), params: { project: { name: '' } }, headers: headers

      expect(response).to have_http_status :internal_server_error
    end

    it 'Should respond with 401(Unauthorized)' do
      path api_v1_project_path(project)

      expect(response).to have_http_status :unauthorized
    end
  end
end
