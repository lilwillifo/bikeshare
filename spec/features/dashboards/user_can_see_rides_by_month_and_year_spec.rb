require 'rails_helper'

describe 'The trips dashboard' do

  before(:each) do
    @date = Time.parse("2018/04/16")
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

    end_date = @date + 1.hours + 13.minutes + 2.seconds
    end_date_2 = @date + 24.hours + 13.minutes + 2.seconds

    @condition = Condition.create!(date: Date.parse("2018/04/16"), max_temperature: 80, mean_temperature: 84, min_temperature: 80, mean_humidity: 99, precipitation: 0, mean_wind_speed: 4, mean_visibility: 9)
    @condition_2 = Condition.create!(date: Date.parse("2018/04/17"), max_temperature: 80, mean_temperature: 84, min_temperature: 80, mean_humidity: 99, precipitation: 0, mean_wind_speed: 4, mean_visibility: 9)

    @trip_1 = Trip.create!(
      duration: 45,
      start_date: @date,
      end_date: end_date,
      bike_id: 1,
      subscription_type: 'Subscriber',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 1,
      condition: @condition
    )

    @trip_2 = Trip.create(
      duration: 55,
      start_date: @date,
      end_date: end_date,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 2,
      condition: @condition
    )

    @trip_3 = Trip.create(
      duration: 50,
      start_date: @date,
      end_date: end_date,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 2,
      condition: @condition
    )

    @trip4 = Trip.create!(
      duration: 50,
      start_date: @date,
      end_date: end_date_2,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 2,
      end_station_id: 2,
      condition: @condition_2
    )
  end

    describe 'for a user or admin' do
      it 'can see the month to month breakdown of rides' do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/trips-dashboard'

        expect(page).to have_content(Trip.include_years_for_rides.keys.first)
        expect(page).to have_content(Trip.include_years_for_rides.values.first)
        expect(page).to have_content(Trip.include_years_for_rides.keys.last)
        expect(page).to have_content(Trip.include_years_for_rides.values.last)
      end
    end
  end
