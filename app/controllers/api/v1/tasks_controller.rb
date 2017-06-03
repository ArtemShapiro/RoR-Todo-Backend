class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project, shallow: true

  def create
    return render json: { error: @task.errors.full_messages }, status: :unprocessable_entity unless @task.save
    render status: :created
  end

  def update
    Tasks::UpdateTask.call(task_params, @task) do
      on(:ok) { render status: :ok }
      on(:failure) { render json: { error: @task.errors.full_messages }, status: :unprocessable_entity }
    end
  end

  def destroy
    @task.destroy ? head(:ok) : head(:internal_server_error)
  end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :priority, :done)
  end
end
