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
        expect(page).to have_content(station.installation_date.strftime('%d %B %Y'))
      end
    end
  end

  scenario 'it can link from the show page' do
    station1 = create(:station)
    station2 = create(:station)
    station3 = create(:station)

    visit "/#{station1.slug}"

    click_link '<< Back to Station Index'

    expect(current_path).to eq(stations_path)
  end
end
