require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:project) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'scopes' do
    it 'should return array of tasks for current project' do
      project = create(:project)
      create_list(:task, Random.new.rand(2..9), project: project)

      expect(project.tasks).to match_array(Task.tasks_for_current_project(project.id))
    end
  end
end
