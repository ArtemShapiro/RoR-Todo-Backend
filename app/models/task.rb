class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :name, :project, presence: true

  before_create :set_priority
  before_update :update_all, if: :priority_changed?

  scope :tasks_for_current_project, -> (project_id) {where(project_id: project_id)}

  private

  def set_priority
    max = Task.tasks_for_current_project(self.project_id).maximum(:priority)
    return self.priority = max.next if max
    self.priority = 0
  end

  def update_all
    tasks = Task.tasks_for_current_project(self.project_id).order(:done, :priority).to_a
    tasks.delete_if { |task| task.id == self.id }
    tasks.insert(self.priority, self).each_with_index do |task, index|
      task.update_columns(priority: index)
    end
  end
end
