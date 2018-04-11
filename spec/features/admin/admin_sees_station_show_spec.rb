require 'rails_helper'

describe 'admin visits stations#show' do
  before(:each) do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @station = create(:station)
    @station_2 = create(:station)
  end

  scenario 'it shows all the attributes' do
    visit "/#{@station.slug}"

    expect(page).to have_content(@station.name)
    expect(page).to have_content(@station.dock_count)
    expect(page).to have_content(@station.city)
    expect(page).to have_content(@station.installation_date)

    expect(page).to_not have_content(@station_2.name)
  end

  scenario 'it has a link to edit stations' do
    visit "/#{@station.slug}"

    expect(page).to have_content('Edit')
  end

  scenario 'it has a link to delete stations' do
    visit "/#{@station.slug}"

    expect(page).to have_content('Delete')
  end
end
