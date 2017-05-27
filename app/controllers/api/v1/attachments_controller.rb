class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    return head(:unprocessable_entity) unless @attachment.save
    render status: :created
  end

  private

  def attachment_params
    params.permit %i(file)
  end
end
