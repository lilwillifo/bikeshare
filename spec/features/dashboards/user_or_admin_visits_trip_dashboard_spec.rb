require 'rails_helper'

describe 'The trips dashboard' do

  before(:each) do
    @user = create(:user)
    @station = create_list(:station, 2)
    date = Time.now
    @trip_1 = Trip.create!(
      duration: 45,
      start_date: date,
      end_date: date + 45.seconds,
      bike_id: 1,
      subscription_type: 'Premium',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 1
    )

    @trip_2 = Trip.create(
      duration: 55,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 1,
      subscription_type: 'Premium',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 1
    )

    @trip_3 = Trip.create(
      duration: 50,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 1,
      subscription_type: 'Premium',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 1
    )
  end

  describe 'for a user or admin' do
    it 'has the average duration' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Average Duration: 50.0 seconds')
    end
  end

  describe 'for a user or admin' do
    it 'has the longest duration' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Longest Ride: 55 seconds')
    end
  end
end
