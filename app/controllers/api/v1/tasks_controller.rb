class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project, shallow: true

  def create
    return head(:unprocessable_entity) unless @task.save
    render status: :created
  end

  def update
    return head(:unprocessable_entity) unless @task.update(task_params)
    render status: :ok
  end

  def destroy
    @task.destroy ? head(:ok) : head(:internal_server_error)
  end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :priority, :done)
  end
end
