require 'rails_helper'

describe 'As a visitor' do
  context 'when I visit the stations index' do
    it 'I see all stations and their attributes' do
      stations = create_list(:station, 5)

      visit '/stations'

      stations.each do |station|
        expect(page).to have_content(station.name)
        expect(page).to have_content(station.dock_count)
        expect(page).to have_content(station.city)
        expect(page).to have_content(station.installation_date)
      end
    end
  end
end
