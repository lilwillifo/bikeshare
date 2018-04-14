require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit the trips index' do
    scenario 'I see the first 30 trips along with a button to see more pages of trips' do
      station = create(:station)
      condition = create(:condition)
      trips = create_list(:trip, 80)

      visit trips_path

      expect(page).to have_content(trips.first.id)
      expect(page).to have_content(trips.first.time_string)
      expect(page).to have_content(trips.first.start_date)
      expect(page).to have_content(trips.first.start_station.name)
      expect(page).to have_content(trips.first.end_date)
      expect(page).to have_content(trips.first.end_station.name)
      expect(page).to have_content(trips.first.bike_id)
      expect(page).to have_content(trips.first.subscription_type)
      expect(page).to have_content(trips.first.zip_code)
      expect(page).to have_content(trips[29].id)
      expect(page).to_not have_content("Trip no.: #{trips[30].id}")
      expect(page).to_not have_content("Trip no.: #{trips[31].id}")

      click_on 'Next'

      expect(page).to have_content(trips[30].id)
      expect(page).to have_content(trips[59].id)
      expect(page).to_not have_content("Trip no.: #{trips[29].id}")
      expect(page).to_not have_content("Trip no.: #{trips[60].id}")

      click_on 'Next'

      expect(page).to have_content(trips[60].id)
      expect(page).to have_content(trips[79].id)
      expect(page).to_not have_content("Trip no.: #{trips[59].id}")

      click_on 'Previous'

      expect(page).to have_content(trips[30].id)
      expect(page).to have_content(trips[59].id)
      expect(page).to_not have_content("Trip no.: #{trips[69].id}")
    end
  end

  scenario 'it can link from the show page' do
    create(:station)
    condition = create(:condition)
    trip = create(:trip)

    visit trip_path(trip)

    click_link '<< Back to Trip Index'

    expect(current_path).to eq(trips_path)
  end
end
