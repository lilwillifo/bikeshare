require 'rails_helper'

describe 'A logged in user' do
  scenario 'can edit information ' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link 'Edit Your Info'
    fill_in 'user[username]', with: 'newkid'
    fill_in 'user[password]', with: 'awman'
    fill_in 'user[password_confirmation]', with: 'awman'
    click_on 'Update User'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_link('newkid')
  end
end
