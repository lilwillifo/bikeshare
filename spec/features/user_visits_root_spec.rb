require 'rails_helper'

describe 'User' do
  scenario 'visits root path' do
    visit root_path

    expect(page).to have_content('Bike Share')
  end
end
