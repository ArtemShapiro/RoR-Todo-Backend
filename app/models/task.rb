class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 48 }
  validates :project, presence: true

  before_create :set_priority

  scope :tasks_for_current_project, -> (project_id) {where(project_id: project_id)}

  private

  def set_priority
    max = Task.tasks_for_current_project(self.project_id).maximum(:priority)
    return self.priority = max.next if max
    self.priority = 0
  end
end
