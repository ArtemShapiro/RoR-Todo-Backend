require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe 'guest' do
    subject { Ability.new(nil) }

    describe 'Project' do
      %i(read create update destroy).each do |ability|
        it { is_expected.not_to be_able_to ability, Project }
      end
    end

    describe 'Todo' do
      %i(read create update destroy).each do |ability|
        it { is_expected.not_to be_able_to ability, Task }
      end
    end

    describe 'Comment' do
      %i(read create update destroy).each do |ability|
        it { is_expected.not_to be_able_to ability, Comment }
      end
    end

    describe 'Attachment' do
      %i(read create update destroy).each do |ability|
        it { is_expected.not_to be_able_to ability, Attachment }
      end
    end
  end

  describe 'user' do
    let(:user) { create :user }
    let(:project) { create :project, user: user }

    subject { Ability.new(user) }

    describe 'Project' do
      %i(read create update destroy).each do |ability|
        it { is_expected.to be_able_to ability, project }
        it { is_expected.not_to be_able_to ability, create(:project) }
      end
    end

    describe 'Task' do
      %i(read create update destroy).each do |ability|
        it { is_expected.to be_able_to ability, create(:task, project: project)}
        it { is_expected.not_to be_able_to ability, create(:task) }
      end
    end

    describe 'Comment' do
      let(:task) { create :task, project: project }

      %i(read create update destroy).each do |ability|
        it { is_expected.to be_able_to ability, create(:comment, task: task)}
        it { is_expected.not_to be_able_to ability, create(:task) }
      end
    end
  end
end
