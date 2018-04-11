require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit the trips index' do
    scenario 'I cannot see the edit or delete links' do
      station = create(:station)
      trips = create_list(:trip, 80)

      visit trips_path

      expect(page).to_not have_link('Edit')
      expect(page).to_not have_link('Delete')
    end
  end
end
