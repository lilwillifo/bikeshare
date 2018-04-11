require 'rails_helper'

describe 'User' do
  scenario 'can login and go to dashboard' do
    user = create(:user)

    visit root_path
    click_on 'Login'

    expect(current_path).to eq('/login')

    fill_in 'username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Submit'

    expect(current_path).to eq('/dashboard')
    within('nav') do
      expect(page).to have_content("Logged in as #{user.username}")
    end
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')
  end
end
