require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks).dependent(:destroy) }

    it 'should return ordered tasks by DONE PRIORITY' do
      project = create(:project)

      done = true
      tasks_count = Random.new.rand(2..9)
      tasks_count.times do
        create(:task, done: done, project: project)
        done = !done
      end

      tasks = project.tasks
      sorted_tasks = project.tasks.order(:done, :priority)
      expect(tasks).to match_array(sorted_tasks)
    end
  end
end
