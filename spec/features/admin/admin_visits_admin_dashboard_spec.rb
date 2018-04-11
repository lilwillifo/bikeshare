require 'rails_helper'

describe 'As an admin' do
  it 'I can login and see my dashboard' do
    admin = create(:admin)

    visit '/'
    click_on 'Login'

    expect(current_path).to eq(login_path)

    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_on 'Submit'

    expect(current_path).to eq('/admin/dashboard')
    within('nav') do
      expect(page).to have_content("Logged in as Admin User: #{admin.username}")
    end
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')

  end


end
