class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task, shallow: true

  def index
  end

  def create
    @comment.attachment = Attachment.find_by(id: params[:file]) if params[:file]
    return head(:unprocessable_entity) unless @comment.save
    render status: :created
  end

  def destroy
    @comment.destroy ? head(:ok) : head(:internal_server_error)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
