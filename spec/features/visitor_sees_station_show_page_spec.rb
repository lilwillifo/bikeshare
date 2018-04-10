require 'rails_helper'

describe 'As a visitor' do
  context 'when I visit the station show page' do
    it 'I see the station name in URL and all attributes for that station' do
      station = create(:station)
      station_2 = create(:station)

      visit "/#{station.name.delete(' ')}"

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)

      expect(page).to_not have_content(station_2.name)
  end
  end
end
