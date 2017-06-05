require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let (:attachment) { attributes_for :attachment }
  let(:headers) { create(:user).create_new_auth_token }

  describe 'POST /api/v1/attachments' do
    it 'Should respond with 201(Created)' do
      post api_v1_attachments_path, params: { file: attachment[:file] }, headers: headers

      expect(response).to be_success
      expect(response).to match_response_schema('attachment')
    end

    it 'Should respond with 422(Unprocessable entity)' do
      post api_v1_attachments_path, params: { file: '' }, headers: headers

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'Should respond with 401(Unauthorized)' do
      post api_v1_attachments_path

      expect(response).to have_http_status :unauthorized
    end
  end
end
