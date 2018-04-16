require 'rails_helper'

describe 'The trips dashboard' do

  before(:each) do
    @date = Date.new(2013,10,4)
    @user = create(:user)
    @station1 = Station.create!(
      name: 'bob',
      dock_count: 10,
      city: 'Modena',
      installation_date: Date.new(2013,10,4),
      slug: 'bob'
    )

    @station2 = Station.create!(
      name: 'sally',
      dock_count: 35,
      city: 'West',
      installation_date: Date.new(2013,10,4),
      slug: 'sally'
    )

    end_date = @date + 1.hours + 13.minutes + 2.seconds
    end_date_2 = @date + 26.hours + 13.minutes + 2.seconds

    @condition = create(:condition, date: end_date, max_temperature: 80, precipitation: 0, mean_wind_speed: 4, mean_visibility: 9)
    @condition_2 = create(:condition, date: end_date_2, max_temperature: 80, precipitation: 0, mean_wind_speed: 4, mean_visibility: 9)

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
        visit '/trips-dashboard'

        expect(page).to have_content("Jan #{rides_in_jan}")
        expect(page).to have_content("Feb: #{rides_in_feb}")
        expect(page).to have_content("Mar: #{rides_in_mar}")
        expect(page).to have_content("Apr: #{rides_in_apr}")
        expect(page).to have_content("May: #{rides_in_may}")
        expect(page).to have_content("June: #{rides_in_jun}")
        expect(page).to have_content("July: #{rides_in_jul}")
        expect(page).to have_content("August: #{rides_in_aug}")
        expect(page).to have_content("September: #{rides_in_sep}")
        expect(page).to have_content("October: #{rides_in_oct}")
        expect(page).to have_content("November: #{rides_in_nov}")
        expect(page).to have_content("December: #{rides_in_dec}")
      end
    end

    describe 'for a user or admin' do
      it 'can see the yearly breakdown for rides' do
        visit '/trips-dashboard'

        expect(page).to have_content('Total Rides in 2014: ')
        expect(page).to have_content('Total Rides in 2013: ')

      end
    end
  end
