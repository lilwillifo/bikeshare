require 'rails_helper'

describe 'admin wants to delete station' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
    @condition = create(:condition)
    @trip = create(:trip)
  end

  describe 'admin visits trips_path' do
    it 'allows deletion of trip' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit trips_path

      within(".trip_#{@trip.id}") do
        find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click
      end

      expect(current_path).to eq(trips_path)
      expect(page).to have_content('Trip Deleted!')
      expect(page).to_not have_content(@trip.time_string)
      expect(page).to_not have_content(@trip.start_date)
      expect(page).to_not have_content(@trip.end_date)
      expect(page).to_not have_content(@trip.bike_id)
      expect(page).to_not have_content(@trip.subscription_type)
      expect(page).to_not have_content(@trip.zip_code)
      expect(page).to_not have_content(@trip.start_station_id)
      expect(page).to_not have_content(@trip.end_station_id)
    end
  end

  describe 'admin visits trips_path' do
    it 'allows use of dlete link from show' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit trip_path(@trip)

      find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click

      expect(current_path).to eq(trips_path)
      expect(page).to have_content('Trip Deleted!')
      expect(page).to_not have_content(@trip.time_string)
      expect(page).to_not have_content(@trip.start_date)
      expect(page).to_not have_content(@trip.end_date)
      expect(page).to_not have_content(@trip.bike_id)
      expect(page).to_not have_content(@trip.subscription_type)
      expect(page).to_not have_content(@trip.zip_code)
      expect(page).to_not have_content(@trip.start_station_id)
      expect(page).to_not have_content(@trip.end_station_id)
    end
  end

  describe 'as a normal user' do
    it 'does not allow user to even see link' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit trips_path

      expect(page).to_not have_content('Delete')
    end
  end

  describe 'as a visitor' do
    it 'does not allow user to even see link' do
      visit trips_path

      expect(page).to_not have_content('Delete')
    end
  end
end
