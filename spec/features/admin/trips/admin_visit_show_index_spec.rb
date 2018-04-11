require 'rails_helper'

describe 'admin visits trips#index' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
    @trip = create(:trip)
  end

  scenario 'it shows all the attributes' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit trip_path(@trip)

    expect(page).to have_content(@trip.duration)
    expect(page).to have_content(@trip.start_date)
    expect(page).to have_content(@trip.end_date)
    expect(page).to have_content(@trip.bike_id)
    expect(page).to have_content(@trip.subscription_type)
    expect(page).to have_content(@trip.zip_code)
    expect(page).to have_content(@trip.start_station_id)
    expect(page).to have_content(@trip.end_station_id)
  end

  scenario 'it has a link to edit trips' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit trip_path(@trip)

    expect(page).to have_content('Edit')
  end

  scenario 'it has a link to delete trips' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit trip_path(@trip)

    expect(page).to have_content('Delete')
  end
end
