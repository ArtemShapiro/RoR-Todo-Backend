require 'rails_helper'

feature 'Projects', type: :feature, js: true, focus: true do
  let (:project_attr) { attributes_for :project }

  context 'User with projects' do
    let (:new_user) { create :user_with_projects }
    let (:projects) { new_user.projects }

    background do
      visit '/'

      fill_in 'email', with: new_user.email
      fill_in 'password', with: new_user.password

      click_button 'Sign in'
    end

    scenario 'User can see list of Projects' do
      projects.each do |project|
        expect(page).to have_content project.name
      end
    end

    scenario 'User can add project' do
      click_button 'Add Project'
      save_and_open_screenshot
      fill_in 'name', with: project_attr[:name]
      click_button 'Create'

      expect(page).to have_content project_attr[:name]
      projects.each do |_project|
        expect(page).to have_content _project.name
      end
    end
  end

  context 'User with project' do
    let (:new_user) { create :user }
    let (:project) { create :project, user: new_user }

    background do
      visit '/'
      fill_in 'email', with: new_user.email
      fill_in 'password', with: new_user.password

      project
      click_button 'Sign in'
    end

    scenario 'User can delete project' do
      expect(page).to have_content project.name
      click_button 'Delete'
      expect(page).not_to have_content project.name
    end

    scenario 'User can update project' do
      expect(page).to have_content project.name
      click_button 'Update'
      fill_in 'name', with: project_attr[:name]
      click_button 'Save'
    end
  end
end
