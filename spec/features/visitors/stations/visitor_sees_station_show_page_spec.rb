require 'rails_helper'

describe 'As a visitor' do
  context 'when I visit the station show page' do
    it 'I see the station name in URL and all attributes for that station' do
      station = create(:station)
      station_2 = create(:station)

      visit "/#{station.slug}"

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)

      expect(page).to_not have_content(station_2.name)
    end
  end

  describe 'it can link from the index page' do
    it 'links correctly' do
      # station = Station.create!(name: 'aether',
      #                           dock_count: 3,
      #                           city: 'San Fran',
      #                           installation_date: Date.new(2012,10,4),
      #                           slug: 'aether')
      station = create(:station)

      visit stations_path

      click_link station.name

      expect(current_path).to eq("/#{station.slug}")
    end
  end
end
