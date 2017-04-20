require 'rails_helper'

feature 'Auth', type: :feature, js: true do
  context 'With valid data' do
    scenario 'Sign in' do
      visit '/'

      new_user = create :user
      fill_in 'email', with: new_user.email
      fill_in 'password', with: new_user.password
      click_button 'Sign in'

      expect(page).to have_content 'Projects'
    end

    scenario 'Sign up' do
      visit '#/sign-up'

      user_attr = attributes_for :user
      fill_in 'email', with: user_attr[:email]
      fill_in 'password', with: user_attr[:password]
      fill_in 'passwordConfirmation', with: user_attr[:password]
      click_button 'Sign Up'

      expect(page).to have_content 'Projects'
    end
  end

  context 'With invalid data' do
    scenario '#sign_in' do
      visit '/'
      click_button 'Sign in'

      expect(page).to have_content 'Sign in'
    end

    scenario 'Sign up' do
      visit '#/sign-up'
      click_button 'Sign Up'

      expect(page).to have_content 'Sign Up'
    end
  end
end
