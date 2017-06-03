module Tasks
  class UpdateTask < Rectify::Command
    def initialize(params, task)
      @params = params
      @task = task
    end

    def call
      transaction do
        update_task
        update_priority if @params[:priority]
      end

      return broadcast(:failure) unless @task.valid?
      broadcast(:ok)
    end

    private

    attr_reader :params, :task

    def update_task
      @task.update(@params)
    end

    def update_priority
      tasks = Task.tasks_for_current_project(@task.project_id).order(:done, :priority).to_a
      tasks.delete_if { |task| task.id == @task.id }
      tasks.insert(@task.priority, @task).each_with_index do |task, index|
        task.update_columns(priority: index)
      end
    end
  end
end
