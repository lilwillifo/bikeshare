require 'rails_helper'

describe 'As a user/admin' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
    @station = create(:station)
    @trips_from_station = create_list(:trip, 3, start_station: @station)
    @trips_end_station = create_list(:trip, 3, end_station: @station)
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context 'when I visit a station show page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit "/#{@station.slug}"

    expect(page).to have_content("Trips from here: #{@station.trips_from}")
  end
end