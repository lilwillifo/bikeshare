require 'rails_helper'

describe 'As a registered user' do
  context 'when I visit the conditions dashboard' do
    it 'shows the rides broken down by weather' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      conditions = create_list(:condition, 3)
      condition_ids = conditions.pluck(:id)
      station = create(:station)
      trips = create_list(:trip, 10)
        trips.map do |trip|
          trip.update(condition_id: condition_ids.sample)
        end

      visit '/conditions-dashboard'

      expect(page).to have_content('Rides by Temperature')
      expect(page).to have_content('Rides by Precipitation')
      expect(page).to have_content('Rides by Wind Speed')
      expect(page).to have_content('Rides by Visibility')
      expect(page).to have_content('Highest Number of Rides')
      expect(page).to have_content('Lowest Number of Rides')
      expect(page).to have_content('Average Rides')
    end
  end
end
