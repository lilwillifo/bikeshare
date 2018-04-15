require 'rails_helper'

describe 'The trips dashboard' do

  before(:each) do
    @user = create(:user)
    @station1 = Station.create!(
      name: 'bob',
      dock_count: 10,
      city: 'Modena',
      installation_date: Date.new(2012,10,4),
      slug: 'bob'
    )

    @station2 = Station.create!(
      name: 'sally',
      dock_count: 35,
      city: 'West',
      installation_date: Date.new(2012,10,4),
      slug: 'sally'
    )

    date = Time.now
    @trip_1 = Trip.create!(
      duration: 45,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 1,
      subscription_type: 'Subscriber',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 1
    )

    @trip_2 = Trip.create(
      duration: 55,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 2
    )

    @trip_3 = Trip.create(
      duration: 50,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 2
    )

    @trip4 = Trip.create!(
      duration: 50,
      start_date: date,
      end_date: date + 26.hours + 13.minutes + 2.seconds,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 2,
      end_station_id: 2
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

  describe 'for a user or admin' do
    it 'has the shortest ride duration' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Shortest Ride: 45 seconds')
    end
  end

  describe 'for a user or admin' do
    it 'has the station with most rides as a starting place' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Most Popular Start Station: #{@station1.name}")
    end
  end

  describe 'for a user or admin' do
    it 'has the station with most rides as a ending place' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Most Popular End Station: #{@station2.name}")
    end
  end

  describe 'for a user or admin' do
    it 'has the most ridden bike with total number of rides for that bike' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Most Ridden Bike: 2, with 3 rides")
    end
  end

  describe 'for a user or admin' do
    it 'has the least ridden bike with total number of rides for that bike' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Least Ridden Bike: 1, with 1 rides")
    end
  end

  describe 'for a user or admin' do
    it 'has the user subscription type breakout with both count and percentage' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("User Subscription Type: 3 customer(s) account for 75.0% of total.")
      expect(page).to have_content("User Subscription Type: 1 subscriber(s) account for 25.0% of total.")
    end
  end

  describe 'for a user or admin' do
    it 'has the date with the hightest number of rides and the count' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Date with the most rides: 04 15 2018, number of rides: 3')
    end
  end

  describe 'for a user or admin' do
    it 'has the date with the least number of rides and the count' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Date with the least rides: 04 16 2018, number of rides: 1')
    end
  end
end
