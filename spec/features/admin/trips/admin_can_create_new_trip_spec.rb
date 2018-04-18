require 'rails_helper'

describe 'admin visits trips#index' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
    @station2 = create(:station)
  end

  describe 'admin visit admin_trip#new' do
    it 'allows the admin to create new station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit new_admin_trip_path

      fill_in 'trip[duration]', with: 60
      fill_in 'trip[start_date]', with: '2018-01-09 18:27:55'
      fill_in 'trip[end_date]', with: '2018-01-09 22:27:55'
      fill_in 'trip[bike_id]', with: 8
      select 'Subscriber', from: 'trip[subscription_type]'
      fill_in 'trip[zip_code]', with: 88888
      select @station.name, from: 'trip[start_station_id]'
      select @station2.name, from: 'trip[end_station_id]'
      click_on 'Create Trip'

      expect(current_path).to eq(trip_path(Trip.all.last))
      expect(page).to have_content('Trip: 1 Created!')
      expect(page).to have_content('09 January 2018')
      expect(page).to have_content('09 January 2018')
      expect(page).to have_content('8')
      expect(page).to have_content('Subscriber')
      expect(page).to have_content('88888')
      expect(page).to have_content('1')
      expect(page).to have_content('2')
    end
  end

  describe 'links from index' do
    it ' to add a new trips' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit trips_path

      click_link 'Add a New Trip!'

      fill_in 'trip[duration]', with: 60
      fill_in 'trip[start_date]', with: '2018-01-09 18:27:55'
      fill_in 'trip[end_date]', with: '2018-01-09 22:27:55'
      fill_in 'trip[bike_id]', with: 8
      select 'Customer', from: 'trip[subscription_type]'
      fill_in 'trip[zip_code]', with: 88888
      select @station.name, from: 'trip[start_station_id]'
      select @station2.name, from: 'trip[end_station_id]'
      click_on 'Create Trip'

      expect(current_path).to eq(trip_path(Trip.all.last))
      expect(page).to have_content('Trip: 1 Created!')
      expect(page).to have_content('09 January 2018')
      expect(page).to have_content('09 January 2018')
      expect(page).to have_content('8')
      expect(page).to have_content('Customer')
      expect(page).to have_content('88888')
      expect(page).to have_content('1')
      expect(page).to have_content('2')
    end
  end

  describe 'as normal user' do
    it 'does not allow default user to see delete link' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_trip_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'as visitor' do
    it 'does not allow visitor to see delete link' do

      visit new_admin_trip_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
