require 'rails_helper'

describe 'admin visits stations#index' do
  before(:each) do
    @admin = create(:admin)
  end

  describe 'admin visit admin_station#new' do
    it 'allows the admin to create new station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit new_admin_station_path

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: '2018-04-10'
      click_on 'Create Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie created!')
      expect(page).to have_content('10')
      expect(page).to have_content('San Fran')
      expect(page).to have_content('10 April 2018')
    end
  end

  describe 'links from index' do
    it ' to add a new station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit stations_path

      click_link 'Add a new station'

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: '2018-04-10'
      click_on 'Create Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie created!')
      expect(page).to have_content('10')
      expect(page).to have_content('San Fran')
      expect(page).to have_content('10 April 2018')
    end
  end

  describe 'as normal user' do
    it 'does not allow default user to see delete link' do
      user = User.create(username: 'fern@gully.com',
                         password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_station_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'as visitor' do
    it 'does not allow visitor to see delete link' do

      visit new_admin_station_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
