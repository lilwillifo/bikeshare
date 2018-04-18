require 'rails_helper'

describe 'As a visitor' do
  context 'when I visit the homepage and click login' do
    it 'I can create an account' do
      visit '/'

      click_link 'Login'

      expect(current_path).to eq('/login')

      click_link 'Create Account'

      expect(current_path).to eq(new_user_path)

      fill_in 'Username', with: 'TylerRox'
      fill_in 'Password', with: 'SeCrEtZ'
      fill_in 'Password confirmation', with: 'SeCrEtZ'
      fill_in 'First name', with: 'lobster'
      fill_in 'Last name', with: 'wassup'
      fill_in 'Address', with: 'loner way'
      click_on 'Submit'

      expect(current_path).to eq ('/dashboard')
      expect(page).to have_content('Logged in as TylerRox')
      expect(page).to have_content('lobster')
      expect(page).to have_content('wassup')
      expect(page).to have_content('loner way')
      expect(page).to have_link('Logout')
      expect(page).to_not have_link('Login')
    end
  end
end
