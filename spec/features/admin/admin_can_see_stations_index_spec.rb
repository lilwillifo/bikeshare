require 'rails_helper'

describe 'admin visits stations#index' do
  before(:each) do
    @admin = create(:admin)
    @stations = create_list(:station, 5)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  scenario 'it shows all the attributes' do
    visit stations_path

    @stations.each do |station|
      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end
  end

  scenario 'it has a link to edit stations' do
    visit stations_path

    expect(page).to have_content('Edit')
  end

  scenario 'it has a link to delete stations' do
    visit stations_path

    expect(page).to have_content('Delete')
  end
end
