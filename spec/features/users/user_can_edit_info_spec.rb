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
    click_on 'Submit'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('newkid, your account has been updated!')
  end

  scenario 'cannot see another users information ' do
    user = User.create!(username: 'bob_ross', password: 'epic')
    user2 = User.create!(username: 'baby_baluga', password: 'test')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit dashboard_path
    expect(page).to_not have_content(user.username)
    expect(page).to have_content(user2.username)
  end

  scenario 'cannot see another users information on edit form' do
    user = User.create!(username: 'bob_ross', password: 'epic')
    user2 = User.create!(username: 'baby_baluga', password: 'test')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit dashboard_path

    click_link 'Edit Your Info'
    expect(page).to_not have_content(user.username)
  end

  scenario 'cannot hack another users edit path ' do
    user = User.create!(username: 'bob_ross', password: 'epic')
    user2 = User.create!(username: 'baby_baluga', password: 'test')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit edit_user_path(user)
    fill_in 'user[username]', with: 'newkid'
    fill_in 'user[password]', with: 'awman'
    fill_in 'user[password_confirmation]', with: 'awman'
    click_on 'Submit'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    expect(page).to have_content(user.username)
    expect(page).to_not have_content('newkid')
  end
end
