require 'rails_helper'

describe 'As a visitor' do
  before(:each) do
    DatabaseCleaner.clean
    @station1 = create(:station)
    @station2 = create(:station)
    @station3 = create(:station)

    create(:condition)
    @trips_from_station = create_list(:trip, 3, start_station: @station1, end_station: @station2)
    create_list(:trip, 5, start_station: @station3, end_station: @station1)
    @trips_end_station = create_list(:trip, 4, start_station: @station2, end_station: @station1)
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context 'when I visit a station show page' do
    scenario 'I cannot see the extra data that only users should see' do
      visit "/#{@station1.slug}"

      expect(page).to_not have_content("Trips from here: #{@station1.start_trips.length}")
      expect(page).to_not have_content("Trips to here: #{@station1.end_trips.length}")
    end
  end
end