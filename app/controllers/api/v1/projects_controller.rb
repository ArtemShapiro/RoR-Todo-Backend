class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @projects
  end

  def create
    return head(:unprocessable_entity) unless @project.save
    render status: :created
  end

  def update
    return head(:unprocessable_entity) unless @project.update(project_params)
    render status: :ok
  end

  def destroy
    @project.destroy ? head(:ok) : head(:internal_server_error)
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
