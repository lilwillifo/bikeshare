require 'rails_helper'

describe 'As a visitor' do
  context 'when I visit the homepage and click login' do
    it 'I can create an account' do
      visit '/'

      click_link 'Login'

      expect(current_path).to eq('/login')

      click_link 'Create Account'
      fill_in 'Username', with: 'TylerRox'
      fill_in 'Password', with: 'SeCrEtZ'
      fill_in 'Confirm Password', with: 'SeCrEtZ'
      click_on 'Submit'

      expect(current_path).to eq ('/dashboard')
      expect(page).to have_content('Logged in as TylerRox')
      expect(page).to have_link('Logout')
      expect(page).to_not have_link('Login')
    end
  end
end
