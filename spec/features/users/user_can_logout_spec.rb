require 'rails_helper'

describe 'A logged in user' do
  scenario 'can logout ' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')
  end
end

describe 'An admin' do
  scenario 'can logout ' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit root_path
    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')
  end
end
