require 'rails_helper'

feature 'Projects', type: :feature, js: true do
  let (:new_user) { create :user_with_projects }
  let (:projects) { new_user.projects }
  let (:project) { attributes_for :project }

  background do
    visit '/'

    fill_in 'email', with: new_user.email
    fill_in 'password', with: new_user.password

    click_button 'Sign in'
  end

  scenario '#user can see list of Projects' do
    projects.each do |project|
      expect(page).to have_content project.name
    end
  end

  scenario '#user can add project' do
    click_button 'Add Project'

    fill_in 'name', with: project[:name]
    click_button 'Create'

    expect(page).to have_content project[:name]
    projects.each do |_project|
      expect(page).to have_content _project.name
    end
  end
end
