class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @projects
  end

  def create
    head(:internal_server_error) unless @project.save
  end

  def update
    @project.update(project_params) ? head(:ok) : head(:internal_server_error)
  end

  def destroy
    @project.destroy ? head(:ok) : head(:internal_server_error)
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
